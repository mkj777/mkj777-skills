---
name: web-audit
description: Performance- und Barrierefreiheits-Audit gegen eine deployte URL mit erzwungener Baseline, priorisierten Findings, Fix-Loop im Repo und Nachmessen nach jedem Fix. Misst mit Lighthouse (Median aus drei Läufen), holt Trace-Einsichten und den A11y-Baum über den Chrome-DevTools-MCP und prüft inhaltlich, was Lighthouse nicht kann (Alt-Texte, Heading-Hierarchie, Fokusreihenfolge, Fehlertexte). Keine Zahl im Report, die nicht aus einem Toolaufruf stammt. Nutze diesen Skill bei "audit die Seite", "Lighthouse-Score verbessern", "Core Web Vitals", "warum ist die Seite langsam", "Barrierefreiheit prüfen", "Performance-Budget in CI". Nur gegen deployte URLs (Produktion oder Preview), nicht gegen lokale Dev-Server. Baut und deployt nicht selbst; Fixes werden über den vorhandenen Deploy-Weg des Projekts live gebracht.
---

# Web Audit

Ein Audit hat drei Teile: messen, verstehen, verbessern. Die Reihenfolge ist fest, und der
Report enthält nur, was gemessen wurde.

## Harte Regeln

1. **Keine Zahl ohne Toolaufruf.** Jede Zahl im Report stammt wörtlich aus `summary.md`,
   `compare.mjs`, einem MCP-Tool oder der Konsole, und trägt das Label ihrer Messung
   (`baseline`, `fix-1`, ...). Keine Schätzung, kein "etwa", kein "sollte jetzt schneller sein".
   Wenn du eine Zahl nicht belegen kannst, schreibst du "nicht gemessen".
2. **Erst Baseline, dann Code anfassen.** Ohne `baseline/summary.json` wird keine Datei im Repo
   geändert.
3. **Nach jedem deployten Fix identisch nachmessen.** Gleiches Preset, gleiche Anzahl Läufe,
   gleiche URL. Mobile wird nur mit mobile verglichen.
4. **Median aus drei Läufen, Warm-up verworfen.** Das macht `measure.mjs`. Überlappen die
   Spannen zweier Messungen, ist das Delta nicht signifikant, und so steht es im Report.
5. **Fix ist live, bevor gemessen wird.** Beleg per `evaluate_script` (geänderter Asset-Hash,
   geändertes Attribut) oder beim Vercel-Projekt per `vercel ls --prod` mit dem neuen Commit.
   Sonst misst man den alten Stand und schreibt Unsinn.
6. **Verschlechterung wird zurückgenommen.** Ein Fix, der eine Kennzahl signifikant
   verschlechtert oder einen A11y-, SEO- oder Best-Practice-Score senkt, wird revertiert und im
   Protokoll als "verworfen" geführt, mit der Zahl, die dagegen sprach.
7. **Kein Zugriff, keine Messung.** Auth-Wall, Consent-Wall, die den Inhalt verdeckt, oder
   HTTP ungleich 200: stoppen und melden, nicht um die Wand herum messen.

## Eingaben

- **URL** (Pflicht): deployte Seite, `https://`.
- **Repo-Pfad** (optional): ohne ihn endet der Skill nach dem Report, ohne Fix-Loop.
- **Preset** (optional): `mobile` (Standard) oder zusätzlich `desktop`.
- **Deploy-Weg** (optional): wie ein Commit live geht. Bei Vercel-Git-Projekten ist es der
  Push auf den Produktions-Branch; sonst nennt es der Nutzer oder `AGENTS.md`.
- **Budget** (optional): Zielwerte, bei deren Erreichen der Loop endet.

Werkzeuge: `scripts/measure.mjs`, `scripts/compare.mjs`, Chrome-DevTools-MCP
(`new_page`, `navigate_page`, `emulate`, `performance_start_trace`, `performance_stop_trace`,
`performance_analyze_insight`, `lighthouse_audit`, `take_snapshot`, `take_screenshot`,
`evaluate_script`, `list_console_messages`, `list_network_requests`).

## Phase 0: Preflight

1. `curl -sSL -o /dev/null -w '%{http_code}' <URL>` muss `200` liefern.
2. Framework erkennen: `package.json` im Repo (`next`, `astro`, `vite`, `@sveltejs/kit`) oder
   im Browser per `evaluate_script`
   (`!!document.querySelector('script[src*="/_next/"]') || !!window.__NEXT_DATA__`).
3. Ausgabeordner: `.audit/<host>/<yyyy-mm-dd>/` im Repo (ist in `.gitignore` aufzunehmen),
   ohne Repo im Arbeitsverzeichnis.
4. Kurz ansagen, was gemessen wird: URL, Preset, Anzahl Läufe, ob ein Fix-Loop folgt.

## Phase 1: Baseline, deterministisch

```bash
SKILL=~/.claude/skills/web-audit
node "$SKILL/scripts/measure.mjs" --url "<URL>" --label baseline --preset mobile
```

Ergebnis: `baseline/summary.md` mit Scores, Kennzahlen (Median und Spanne), LCP-Element, den
zehn größten Einsparungen laut Lighthouse und den nicht bestandenen A11y-, SEO- und
Best-Practice-Audits. Diese Datei wird unverändert in den Report übernommen.

Bei Bedarf dasselbe mit `--preset desktop --label baseline-desktop`.

## Phase 2: Baseline, Tiefe über den Chrome-DevTools-MCP

1. `new_page` mit der URL, dann `emulate` mit `networkConditions: "Slow 4G"`,
   `cpuThrottlingRate: 4`, `viewport: "390x844x3,mobile,touch"`.
2. `performance_start_trace` mit `reload: true, autoStop: true`; danach liefert
   `performance_stop_trace` die Insight-Sets. `performance_analyze_insight` für `LCPBreakdown`
   (welche Phase dominiert: TTFB, Load Delay, Load Time, Render Delay), `DocumentLatency`
   und `RenderBlocking`, sofern vorhanden.
3. `lighthouse_audit` mit `device: "mobile"` für die Detailtexte der A11y-, SEO- und
   Best-Practice-Audits (die Performance-Kategorie kommt aus Phase 1, nicht von hier).
4. `list_console_messages`: Fehler und Warnungen zählen, die ersten drei wörtlich notieren.
   Hydration-Fehler sind ein eigenes Finding.
5. `list_network_requests`: Anzahl Requests, größte Antworten, Drittdomains.

Alle Aussagen aus dieser Phase werden mit dem Toolnamen zitiert, aus dem sie stammen.

## Phase 3: Inhaltliche A11y-Prüfung

`take_snapshot` (A11y-Baum) und `take_screenshot` (Viewport und `fullPage`), dann die
Checkliste in [references/a11y-checklist.md](references/a11y-checklist.md) abarbeiten:
Überschriften gegen den Inhalt, Alt-Texte inhaltlich, Link- und Button-Texte, Fokusreihenfolge
und sichtbarer Fokus per `evaluate_script`, Formulare und Fehlertexte, `lang`, Landmarks.

Jedes Finding nennt das Element aus dem Snapshot oder einen Selektor. Kontrast wird nicht
geschätzt, sondern nur aus dem Lighthouse-Audit `color-contrast` übernommen.

## Phase 4: Priorisieren

Tabelle nach [references/report-template.md](references/report-template.md): Finding,
betroffene Kennzahl, Ersparnis laut Lighthouse (nur aus `summary.md`, sonst "keine Angabe"),
Aufwand, Fix-Quelle. Reihenfolge: LCP, dann TBT, dann CLS, dann A11y-Findings der Schwere
hoch, dann der Rest.

Bei Next.js kommt der Fix aus [references/nextjs-fixes.md](references/nextjs-fixes.md); die
Tabelle dort bildet Audit-IDs auf die Handvoll Fixes ab, die fast immer richtig sind. Für
Astro, Vite und statisches HTML steht am Ende derselben Datei die Entsprechung. Steht ein Audit
nicht in der Tabelle, wird der Lighthouse-Text gelesen und der Fix begründet.

Zeige die Priorisierung dem Nutzer, bevor der Loop beginnt. Ohne Repo-Pfad endet der Skill hier
mit dem Report aus Phase 6.

## Phase 5: Fix-Loop

Pro Durchgang eine Fix-Gruppe: mehrere kleine Änderungen derselben Art (etwa alle Bilder auf
`next/image`) dürfen zusammen, damit nicht pro Zeile deployt wird. Verschiedene Kennzahlen
werden getrennt gefixt, sonst ist das Delta nicht zuordenbar.

1. Fix im Repo umsetzen. Keine Nebenänderungen.
2. Lokale Prüfung, die das Projekt kennt (`pnpm build`, `pnpm lint`, was `AGENTS.md` nennt).
3. Commit mit Conventional-Commit-Nachricht, die den Audit nennt (`perf: preload hero image
   (web-audit fix-1)`). Push oder der genannte Deploy-Weg.
4. Live-Check nach Regel 5. Bei Vercel: `vercel ls --prod` zeigt das Deployment zum Commit als
   Ready; zusätzlich `evaluate_script` auf ein Merkmal des Fixes.
5. `node "$SKILL/scripts/measure.mjs" --url "<URL>" --label fix-N --preset mobile`
6. `node "$SKILL/scripts/compare.mjs" <out>/baseline <out>/fix-N` und die Ausgabe unverändert
   ins Protokoll.
7. Entscheidung nach Regel 6: behalten oder revertieren (Revert-Commit, erneut deployen, nicht
   erneut messen, die Baseline-Werte gelten wieder).

Abbruch des Loops: Budget erreicht, keine Findings mit Ersparnis über 100 ms und keine
A11y-Findings der Schwere hoch mehr offen, drei Fixes nacheinander nicht signifikant, oder das
vom Nutzer genannte Limit.

## Phase 6: Report

`REPORT.md` im Ausgabeordner nach [references/report-template.md](references/report-template.md):
Baseline-Tabellen, Trace-Einsichten, A11y-Findings, Priorisierung, Fix-Protokoll mit den
`compare.mjs`-Ausgaben, Ergebnis gegen Baseline, Variabilitätshinweis, offene Punkte.

Der Abschlusstext im Chat ist kurz: Baseline-Score und Endscore mit Label, die zwei bis drei
wirksamsten Fixes mit ihrem gemessenen Delta, was offen blieb. Alles andere steht im Report.

## Phase 7 (optional): CI-Budget

Wenn der Nutzer es will oder das Repo eine CI hat: `lighthouserc.json` und Workflow nach
[references/ci.md](references/ci.md), Budgets aus der letzten behaltenen Messung abgeleitet
(Score minus 5, Metriken plus 15 Prozent). Herkunft der Zahlen in der Commit-Message nennen.

## Was dieser Skill nicht tut

- Kein Messen gegen `localhost` oder Dev-Server; die Zahlen wären wertlos.
- Kein Bauen und kein Deploy als eigener Schritt; dafür sind die Deploy-Skills des Projekts da.
- Keine Field-Daten (CrUX) als Ersatz für Messungen; wenn der MCP welche liefert, werden sie
  als "Felddaten laut Tool" getrennt ausgewiesen.
- Kein Design-Urteil. Wenn die Seite hässlich ist, ist das ein anderer Skill.
