# Report-Vorlage

Der Report ist die Datei `.audit/<host>/<datum>/REPORT.md`. Jede Zahl darin stammt wörtlich aus
`summary.md` oder aus der Ausgabe von `compare.mjs` und trägt das Label der Messung. Zahlen aus
dem Kopf sind verboten. Formulierungen wie "deutlich schneller" oder "sollte jetzt besser sein"
sind verboten; es gibt nur "gemessen" und "nicht gemessen".

```markdown
# Audit <URL>

Datum: <yyyy-mm-dd>. Gerät: <mobile|desktop>. Läufe pro Messung: <n> nach einem Warm-up.
Lighthouse <version> über @lhci/cli, Throttling: <throttlingMethod>.
Repo: <pfad oder "kein Repo, nur Audit">. Deploy-Weg: <Vercel-Git-Push | anderer | keiner>.

## Baseline

<summary.md der Messung `baseline`, Tabellen unverändert übernommen>

### Trace-Einsichten (Chrome DevTools MCP, Slow 4G, CPU 4x)

- LCPBreakdown: <Phasen und Zeiten wie vom Tool geliefert>
- DocumentLatency: <Aussage des Tools>
- RenderBlocking: <Liste der Ressourcen, wie vom Tool geliefert>
- Konsole: <Anzahl Fehler und Warnungen aus list_console_messages, die ersten drei wörtlich>

### Inhaltliche A11y-Prüfung

<Findings im Format aus a11y-checklist.md, sortiert nach Schwere. Jedes Finding mit Element.>

## Priorisierung

| Nr. | Finding | Kennzahl | Ersparnis laut Lighthouse (`baseline`) | Aufwand | Fix-Quelle |
|---|---|---|---|---|---|
| 1 | ... | LCP | <savingsMs aus summary.md oder "keine Angabe"> | klein/mittel/groß | nextjs-fixes.md Zeile ... |

Reihenfolge: LCP, dann TBT, dann CLS, dann A11y hoch, dann der Rest.

## Fix-Protokoll

### fix-1: <Titel>

- Änderung: <Dateien und was genau>
- Commit: <hash>, live geprüft durch: <Asset-Hash | Attribut | vercel ls, wörtlich>
- Messung: `fix-1`

<Ausgabe von compare.mjs baseline fix-1, unverändert>

Entscheidung: behalten | verworfen (Grund: <Kennzahl aus der Tabelle>)

### fix-2: ...

## Ergebnis

<Ausgabe von compare.mjs baseline <letztes behaltenes Label>, unverändert>

Variabilität: <Spannen aus summary.md der letzten Messung; wenn Performance-Spanne über 10
Punkte oder LCP-Spanne über 25 Prozent, steht hier, dass Deltas darunter nicht belastbar sind>

## Offen

- <Findings, die nicht angefasst wurden, mit Grund>
- <Was nur der Nutzer entscheiden kann>

## CI-Budget

<eingerichtet mit lighthouserc.json (Pfad) | nicht eingerichtet, Vorschlag in references/ci.md>
```
