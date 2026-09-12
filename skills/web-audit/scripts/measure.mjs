#!/usr/bin/env node
// Misst eine deployte URL mit der Lighthouse-CLI: ein Warm-up-Lauf (verworfen), danach N Läufe,
// Median nach Performance-Score (Gleichstand: kleinerer LCP). Schreibt manifest.json, summary.json
// und summary.md. Die Ausgabe dieses Skripts ist die einzige zulässige Zahlenquelle für den
// Audit-Report.
//
// Lighthouse wird direkt aufgerufen statt über @lhci/cli, weil chrome-launcher unter Windows nach
// dem Lauf sein Temp-Profil nicht löschen kann und mit Exit 1 endet, obwohl der Report bereits
// geschrieben ist. Dieses Skript akzeptiert Exit 1, wenn die Ausgabedatei ein gültiger Report ist.
//
// Aufruf:
//   node measure.mjs --url <https://...> --label <baseline|fix-1|...> [--preset mobile|desktop]
//                    [--runs 3] [--out <ordner>] [--no-warmup]
//
// Ausgabe: <out>/<label>/{manifest.json, lhr-*.json, summary.json, summary.md}
// Standard-Ausgabeordner: .audit/<host>/<yyyy-mm-dd>

import { spawnSync } from "node:child_process";
import { existsSync, mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { join, resolve } from "node:path";

const LIGHTHOUSE_VERSION = "13.4.1";

function parseArgs(argv) {
  const args = { preset: "mobile", runs: 3, warmup: true };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    const next = () => argv[++i];
    if (a === "--url") args.url = next();
    else if (a === "--label") args.label = next();
    else if (a === "--preset") args.preset = next();
    else if (a === "--runs") args.runs = Number(next());
    else if (a === "--out") args.out = next();
    else if (a === "--no-warmup") args.warmup = false;
    else if (a === "--help" || a === "-h") args.help = true;
    else fail(`Unbekannte Option: ${a}`);
  }
  return args;
}

function fail(msg) {
  console.error(`FEHLER: ${msg}`);
  process.exit(1);
}

function usage() {
  console.log(`Aufruf: node measure.mjs --url <https://...> --label <name> [--preset mobile|desktop] [--runs 3] [--out <ordner>] [--no-warmup]`);
}

function isoDate() {
  return new Date().toISOString().slice(0, 10);
}

function runLighthouseOnce(args, outFile) {
  const lhArgs = [
    "-y", `lighthouse@${LIGHTHOUSE_VERSION}`, args.url,
    "--output=json", `--output-path=${outFile}`, "--quiet",
    "--chrome-flags=--headless=new",
  ];
  if (args.preset === "desktop") lhArgs.push("--preset=desktop");
  let res;
  if (process.platform === "win32") {
    // npx ist unter Windows ein .cmd-Wrapper und braucht eine Shell; Argumente werden selbst gequotet.
    const quoted = lhArgs.map((a) => `"${a.replace(/"/g, '\\"')}"`).join(" ");
    res = spawnSync(`npx ${quoted}`, { stdio: ["ignore", "pipe", "pipe"], encoding: "utf8", shell: true });
  } else {
    res = spawnSync("npx", lhArgs, { stdio: ["ignore", "pipe", "pipe"], encoding: "utf8" });
  }
  let lhr = null;
  if (existsSync(outFile)) {
    try { lhr = JSON.parse(readFileSync(outFile, "utf8")); } catch { lhr = null; }
  }
  const valid = lhr && lhr.lighthouseVersion && lhr.categories && lhr.audits;
  if (!valid) {
    console.error(res.stdout);
    console.error(res.stderr);
    fail(`Lighthouse ist mit Code ${res.status} fehlgeschlagen und hat keinen gültigen Report geschrieben.`);
  }
  if (lhr.runtimeError) {
    fail(`Lighthouse-Laufzeitfehler: ${lhr.runtimeError.code} ${lhr.runtimeError.message}`);
  }
  if (res.status !== 0) {
    // Bekannt unter Windows: chrome-launcher kann sein Temp-Profil nicht löschen (EPERM),
    // der Report ist trotzdem vollständig. Wird nur vermerkt.
    console.error(`Hinweis: Lighthouse endete mit Code ${res.status}, Report ist gültig (${outFile}).`);
  }
  return lhr;
}

function runSeries(args, outputDir, numberOfRuns) {
  const entries = [];
  for (let i = 0; i < numberOfRuns; i++) {
    const file = join(outputDir, `lhr-${i + 1}.json`);
    console.error(`  Lauf ${i + 1}/${numberOfRuns} ...`);
    const lhr = runLighthouseOnce(args, file);
    entries.push({
      url: args.url,
      jsonPath: `lhr-${i + 1}.json`,
      performance: lhr.categories.performance?.score ?? null,
      lcp: lhr.audits["largest-contentful-paint"]?.numericValue ?? null,
      isRepresentativeRun: false,
    });
  }
  // Median nach Performance-Score, bei Gleichstand kleinerer LCP; bei gerader Anzahl der untere Mittelwert.
  const sorted = [...entries].sort((a, b) => (a.performance - b.performance) || (a.lcp - b.lcp));
  const median = sorted[Math.floor((sorted.length - 1) / 2)];
  median.isRepresentativeRun = true;
  writeFileSync(join(outputDir, "manifest.json"), JSON.stringify(entries, null, 2));
}

function readManifest(dir) {
  const manifestPath = join(dir, "manifest.json");
  if (!existsSync(manifestPath)) fail(`manifest.json fehlt in ${dir}`);
  return JSON.parse(readFileSync(manifestPath, "utf8"));
}

function loadLhr(dir, entry) {
  const p = resolve(dir, entry.jsonPath);
  return JSON.parse(readFileSync(p, "utf8"));
}

function metric(lhr, id) {
  const a = lhr.audits[id];
  if (!a) return null;
  return { value: a.numericValue ?? null, unit: a.numericUnit ?? null, score: a.score ?? null, display: a.displayValue ?? null };
}

function ms(v) {
  return v == null ? "n/a" : `${Math.round(v)} ms`;
}

function score(v) {
  return v == null ? "n/a" : String(Math.round(v * 100));
}

function summarize(args, dir) {
  const manifest = readManifest(dir);
  const runs = manifest.map((entry) => ({ entry, lhr: loadLhr(dir, entry) }));
  const rep = runs.find((r) => r.entry.isRepresentativeRun) ?? runs[0];
  const lhr = rep.lhr;

  const cats = Object.fromEntries(Object.entries(lhr.categories).map(([k, v]) => [k, v.score]));
  const metricIds = {
    lcp: "largest-contentful-paint",
    fcp: "first-contentful-paint",
    tbt: "total-blocking-time",
    cls: "cumulative-layout-shift",
    si: "speed-index",
    ttfb: "server-response-time",
  };
  const metrics = Object.fromEntries(Object.entries(metricIds).map(([k, id]) => [k, metric(lhr, id)]));

  const spread = (getter) => {
    const vals = runs.map(getter).filter((v) => v != null);
    if (!vals.length) return null;
    return { min: Math.min(...vals), max: Math.max(...vals), n: vals.length };
  };
  const spreads = {
    performance: spread((r) => r.lhr.categories.performance?.score),
    lcp: spread((r) => r.lhr.audits[metricIds.lcp]?.numericValue),
    tbt: spread((r) => r.lhr.audits[metricIds.tbt]?.numericValue),
    cls: spread((r) => r.lhr.audits[metricIds.cls]?.numericValue),
  };

  const lcpElement = lhr.audits["largest-contentful-paint-element"]?.details?.items?.[0]?.items?.[0]?.node ?? null;

  const opportunities = Object.values(lhr.audits)
    .filter((a) => a.details && (a.details.overallSavingsMs > 0 || a.details.overallSavingsBytes > 0))
    .map((a) => ({
      id: a.id,
      title: a.title,
      score: a.score,
      savingsMs: a.details.overallSavingsMs ?? 0,
      savingsBytes: a.details.overallSavingsBytes ?? 0,
      display: a.displayValue ?? null,
    }))
    .sort((x, y) => (y.savingsMs - x.savingsMs) || (y.savingsBytes - x.savingsBytes))
    .slice(0, 10);

  const failingNonPerf = [];
  for (const catId of ["accessibility", "seo", "best-practices"]) {
    const cat = lhr.categories[catId];
    if (!cat) continue;
    for (const ref of cat.auditRefs) {
      const a = lhr.audits[ref.id];
      if (a && a.score != null && a.score < 1 && a.scoreDisplayMode === "binary") {
        failingNonPerf.push({ category: catId, id: a.id, title: a.title, itemCount: a.details?.items?.length ?? null });
      }
    }
  }

  const summary = {
    label: args.label,
    url: args.url,
    finalUrl: lhr.finalDisplayedUrl ?? lhr.finalUrl ?? null,
    preset: args.preset,
    runs: runs.length,
    warmup: args.warmup,
    representativeRun: rep.entry.jsonPath,
    lighthouseVersion: lhr.lighthouseVersion,
    fetchTime: lhr.fetchTime,
    throttlingMethod: lhr.configSettings?.throttlingMethod ?? null,
    formFactor: lhr.configSettings?.formFactor ?? null,
    scores: cats,
    metrics,
    spreads,
    lcpElement: lcpElement ? { selector: lcpElement.selector, snippet: lcpElement.snippet, nodeLabel: lcpElement.nodeLabel } : null,
    opportunities,
    failingNonPerformanceAudits: failingNonPerf,
  };

  const lines = [];
  lines.push(`## Messung \`${args.label}\` (${args.preset}, ${runs.length} Läufe, Median)`);
  lines.push("");
  lines.push(`URL: ${summary.finalUrl ?? args.url}  `);
  lines.push(`Lighthouse ${summary.lighthouseVersion}, Throttling: ${summary.throttlingMethod}, Zeit: ${summary.fetchTime}`);
  lines.push("");
  lines.push("| Kategorie | Score |");
  lines.push("|---|---|");
  for (const [k, v] of Object.entries(cats)) lines.push(`| ${k} | ${score(v)} |`);
  lines.push("");
  lines.push("| Metrik | Median | Spanne (min bis max) |");
  lines.push("|---|---|---|");
  const spreadTxt = (s, fmt) => (s ? `${fmt(s.min)} bis ${fmt(s.max)}` : "n/a");
  lines.push(`| Performance-Score | ${score(cats.performance)} | ${spreadTxt(spreads.performance, score)} |`);
  lines.push(`| LCP | ${ms(metrics.lcp?.value)} | ${spreadTxt(spreads.lcp, ms)} |`);
  lines.push(`| FCP | ${ms(metrics.fcp?.value)} | |`);
  lines.push(`| TBT | ${ms(metrics.tbt?.value)} | ${spreadTxt(spreads.tbt, ms)} |`);
  lines.push(`| CLS | ${metrics.cls?.value == null ? "n/a" : metrics.cls.value.toFixed(3)} | ${spreads.cls ? `${spreads.cls.min.toFixed(3)} bis ${spreads.cls.max.toFixed(3)}` : "n/a"} |`);
  lines.push(`| Speed Index | ${ms(metrics.si?.value)} | |`);
  lines.push(`| TTFB | ${ms(metrics.ttfb?.value)} | |`);
  lines.push("");
  if (summary.lcpElement) {
    lines.push(`LCP-Element: \`${summary.lcpElement.selector}\`  `);
    lines.push(`\`${(summary.lcpElement.snippet ?? "").slice(0, 200)}\``);
    lines.push("");
  }
  lines.push("### Größte Einsparungen laut Lighthouse");
  lines.push("");
  lines.push("| Audit | Ersparnis | Bytes |");
  lines.push("|---|---|---|");
  for (const o of opportunities) lines.push(`| ${o.id} | ${ms(o.savingsMs)} | ${o.savingsBytes ? `${Math.round(o.savingsBytes / 1024)} KiB` : "" } |`);
  if (!opportunities.length) lines.push("| (keine) | | |");
  lines.push("");
  lines.push("### Nicht bestandene A11y-, SEO- und Best-Practice-Audits");
  lines.push("");
  lines.push("| Kategorie | Audit | Elemente |");
  lines.push("|---|---|---|");
  for (const f of failingNonPerf) lines.push(`| ${f.category} | ${f.id} | ${f.itemCount ?? ""} |`);
  if (!failingNonPerf.length) lines.push("| (keine) | | |");
  lines.push("");

  const md = lines.join("\n");
  writeFileSync(join(dir, "summary.json"), JSON.stringify(summary, null, 2));
  writeFileSync(join(dir, "summary.md"), md);
  return md;
}

function main() {
  const args = parseArgs(process.argv.slice(2));
  if (args.help) return usage();
  if (!args.url) fail("--url fehlt.");
  if (!args.label) fail("--label fehlt.");
  if (!/^https?:\/\//.test(args.url)) fail("--url muss mit http:// oder https:// beginnen.");
  if (!["mobile", "desktop"].includes(args.preset)) fail("--preset muss mobile oder desktop sein.");
  if (!Number.isInteger(args.runs) || args.runs < 1 || args.runs > 9) fail("--runs muss zwischen 1 und 9 liegen.");
  if (!/^[a-z0-9][a-z0-9._-]*$/i.test(args.label)) fail("--label darf nur Buchstaben, Ziffern, Punkt, Unterstrich und Bindestrich enthalten.");

  const host = new URL(args.url).host.replace(/[^a-z0-9.-]/gi, "_");
  const outRoot = resolve(args.out ?? join(".audit", host, isoDate()));
  const dir = join(outRoot, args.label);
  if (existsSync(dir) && readdirSync(dir).length) fail(`Ausgabeordner existiert schon und ist nicht leer: ${dir}. Anderes Label wählen, damit keine Messung überschrieben wird.`);
  mkdirSync(dir, { recursive: true });

  if (args.warmup) {
    const warm = join(dir, "warmup");
    mkdirSync(warm, { recursive: true });
    console.error(`Warm-up-Lauf gegen ${args.url} (wird verworfen) ...`);
    runSeries(args, warm, 1);
    rmSync(warm, { recursive: true, force: true });
  }

  console.error(`${args.runs} Messläufe (${args.preset}) gegen ${args.url} ...`);
  runSeries(args, dir, args.runs);
  const md = summarize(args, dir);
  console.log(md);
  console.error(`Ergebnis: ${join(dir, "summary.json")}`);
}

main();
