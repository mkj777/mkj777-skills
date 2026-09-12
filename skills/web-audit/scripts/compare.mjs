#!/usr/bin/env node
// Vergleicht zwei Messungen von measure.mjs und gibt eine Delta-Tabelle aus.
// Ein Delta gilt nur dann als signifikant, wenn die beiden Messspannen (min bis max der Läufe)
// sich nicht überlappen. Alles andere wird als "nicht signifikant" markiert.
//
// Aufruf: node compare.mjs <ordner-a> <ordner-b>      (jeweils der Ordner mit summary.json)

import { existsSync, readFileSync } from "node:fs";
import { join, resolve } from "node:path";

function fail(msg) {
  console.error(`FEHLER: ${msg}`);
  process.exit(1);
}

function load(dir) {
  const p = resolve(dir, "summary.json");
  if (!existsSync(p)) fail(`summary.json fehlt in ${dir}`);
  return JSON.parse(readFileSync(p, "utf8"));
}

function overlap(a, b) {
  if (!a || !b) return null;
  return !(a.max < b.min || b.max < a.min);
}

function fmtMs(v) {
  return v == null ? "n/a" : `${Math.round(v)} ms`;
}
function fmtScore(v) {
  return v == null ? "n/a" : String(Math.round(v * 100));
}
function fmtCls(v) {
  return v == null ? "n/a" : v.toFixed(3);
}

function row(name, a, b, fmt, spreadA, spreadB, lowerIsBetter = true) {
  if (a == null || b == null) return `| ${name} | ${fmt(a)} | ${fmt(b)} | n/a | |`;
  const delta = b - a;
  const pct = a !== 0 ? (delta / a) * 100 : null;
  const better = lowerIsBetter ? delta < 0 : delta > 0;
  const ov = overlap(spreadA, spreadB);
  let verdict;
  if (ov === null) verdict = "keine Spanne";
  else if (ov) verdict = "nicht signifikant (Spannen überlappen)";
  else verdict = better ? "besser" : "schlechter";
  const deltaTxt = fmt === fmtScore ? `${delta >= 0 ? "+" : ""}${Math.round(delta * 100)}` : `${delta >= 0 ? "+" : ""}${fmt(delta)}`;
  const pctTxt = pct == null ? "" : ` (${pct >= 0 ? "+" : ""}${pct.toFixed(1)} %)`;
  return `| ${name} | ${fmt(a)} | ${fmt(b)} | ${deltaTxt}${pctTxt} | ${verdict} |`;
}

function main() {
  const [dirA, dirB] = process.argv.slice(2);
  if (!dirA || !dirB) fail("Aufruf: node compare.mjs <ordner-a> <ordner-b>");
  const a = load(dirA);
  const b = load(dirB);
  if (a.preset !== b.preset) fail(`Presets unterscheiden sich (${a.preset} vs ${b.preset}). Nur gleiche Geräteklassen vergleichen.`);
  if (a.url !== b.url) console.error(`HINWEIS: URLs unterscheiden sich (${a.url} vs ${b.url}).`);

  const lines = [];
  lines.push(`## Vergleich \`${a.label}\` gegen \`${b.label}\` (${a.preset})`);
  lines.push("");
  lines.push(`Läufe: ${a.runs} und ${b.runs}. Lighthouse ${a.lighthouseVersion} und ${b.lighthouseVersion}.`);
  lines.push("");
  lines.push(`| Kennzahl | ${a.label} | ${b.label} | Delta | Bewertung |`);
  lines.push("|---|---|---|---|---|");
  lines.push(row("Performance-Score", a.scores.performance, b.scores.performance, fmtScore, a.spreads.performance, b.spreads.performance, false));
  lines.push(row("LCP", a.metrics.lcp?.value, b.metrics.lcp?.value, fmtMs, a.spreads.lcp, b.spreads.lcp));
  lines.push(row("TBT", a.metrics.tbt?.value, b.metrics.tbt?.value, fmtMs, a.spreads.tbt, b.spreads.tbt));
  lines.push(row("CLS", a.metrics.cls?.value, b.metrics.cls?.value, fmtCls, a.spreads.cls, b.spreads.cls));
  lines.push(row("FCP", a.metrics.fcp?.value, b.metrics.fcp?.value, fmtMs, null, null));
  lines.push(row("Speed Index", a.metrics.si?.value, b.metrics.si?.value, fmtMs, null, null));
  lines.push(row("TTFB", a.metrics.ttfb?.value, b.metrics.ttfb?.value, fmtMs, null, null));
  for (const cat of ["accessibility", "best-practices", "seo"]) {
    lines.push(row(`${cat}-Score`, a.scores[cat], b.scores[cat], fmtScore, null, null, false));
  }
  lines.push("");

  const idsA = new Set(a.failingNonPerformanceAudits.map((f) => f.id));
  const idsB = new Set(b.failingNonPerformanceAudits.map((f) => f.id));
  const fixed = [...idsA].filter((id) => !idsB.has(id));
  const regressed = [...idsB].filter((id) => !idsA.has(id));
  lines.push(`Behobene Audits: ${fixed.length ? fixed.join(", ") : "keine"}  `);
  lines.push(`Neu fehlgeschlagene Audits: ${regressed.length ? regressed.join(", ") : "keine"}`);
  lines.push("");
  lines.push("Spannen ohne Angabe (FCP, Speed Index, TTFB, Kategorie-Scores) tragen keine Signifikanzbewertung.");
  console.log(lines.join("\n"));
}

main();
