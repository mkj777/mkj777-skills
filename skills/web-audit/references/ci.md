# Harte Schwellen in CI mit Lighthouse CI

Der deterministische Teil, der ohne Agent läuft. Der Skill legt die Dateien nur an, wenn der
Nutzer es will oder das Repo bereits eine CI hat; Budgets werden aus der letzten behaltenen
Messung abgeleitet, nicht erfunden: Score-Budget ist der gemessene Score minus 5 Punkte,
Metrik-Budget der gemessene Wert plus 15 Prozent, gerundet. So schlägt CI bei Regression an,
nicht bei normaler Streuung.

## `lighthouserc.json` im Repo-Root

```json
{
  "ci": {
    "collect": {
      "url": ["https://<preview-oder-prod-url>/"],
      "numberOfRuns": 3,
      "settings": { "preset": "mobile" }
    },
    "assert": {
      "assertions": {
        "categories:performance": ["error", { "minScore": 0.85 }],
        "categories:accessibility": ["error", { "minScore": 0.95 }],
        "categories:best-practices": ["warn", { "minScore": 0.9 }],
        "categories:seo": ["warn", { "minScore": 0.9 }],
        "largest-contentful-paint": ["error", { "maxNumericValue": 2500 }],
        "total-blocking-time": ["error", { "maxNumericValue": 200 }],
        "cumulative-layout-shift": ["error", { "maxNumericValue": 0.1 }],
        "errors-in-console": "warn"
      }
    },
    "upload": { "target": "filesystem", "outputDir": ".lighthouseci-report" }
  }
}
```

Die Zahlen oben sind Beispielwerte. Vor dem Anlegen durch die aus der Messung abgeleiteten
ersetzen und die Herkunft in der Commit-Message nennen.

## GitHub Actions gegen die Vercel-Preview-URL

```yaml
name: lighthouse
on:
  pull_request:
jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - name: Preview-URL abwarten
        id: preview
        uses: patrickedqvist/wait-for-vercel-preview@v1.3.2
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          max_timeout: 600
      - name: Lighthouse CI
        run: |
          npx -y @lhci/cli@0.15.1 autorun \
            --collect.url="${{ steps.preview.outputs.url }}/" \
            --collect.numberOfRuns=3
      - uses: actions/upload-artifact@v4
        if: always()
        with:
          name: lighthouse-report
          path: .lighthouseci-report
```

Ohne Vercel-Preview: `collect.url` auf die Produktions-URL setzen und den Job auf `push` zu
`main` laufen lassen. Dann prüft CI nach dem Deploy, nicht davor.

## Lokal ausführen

```bash
npx -y @lhci/cli@0.15.1 autorun
```

Nutzt `lighthouserc.json` im aktuellen Verzeichnis. Exit-Code ungleich 0 bei verletzter
`error`-Assertion.
