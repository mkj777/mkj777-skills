---
name: vbelt-deploy
description: Veröffentlicht das aktuelle pnpm-Webprojekt sofort als Vercel-Projekt <slug> mit Git-Auto-Deploy. Legt bei Bedarf ein GitHub-Repository an (im Account des angemeldeten Nutzers oder in der konfigurierten Organisation), committed und pusht, verbindet das Repo mit Vercel, deployt ohne zusätzliche Freigabe, weist optional <slug>.<eigene Domain> zu und verifiziert die Live-URL. Nutze diesen Skill bei Formulierungen wie "deploye das auf Vercel", "mach die Seite live", "veröffentliche als mein-slug" oder "Akquise-Seite ausrollen", wenn das Projekt pnpm verwenden soll. Für den Coolify-Ablauf ist web-belt-deploy zuständig.
---

# VBelt Deploy

Veröffentliche das aktuelle Projekt ohne separate Planfreigabe. Der Nutzer hat Repo-Erstellung,
Push, Vercel-Projektanlage, Git-Anbindung und die öffentliche URL für diesen Workflow vorab
autorisiert.

Stammt der Lead aus der Lead-API, gehört nach dem verifizierten Deploy die `built`-Meldung dazu,
die macht `vbelt-lead`, nicht dieser Skill.

## Feste Ziele

- Plattform: Vercel, Projektname `<slug>`, Scope aus `deploy.vercel_scope`
- Auto-Deploy: jeder Push auf den Produktions-Branch baut neu (Vercel-Git-Anbindung)
- Live-URL: Produktions-Alias von Vercel (`<slug>.vercel.app` oder mit Suffix), oder
  `<slug>.<deploy.domain>`, wenn eine eigene Domain konfiguriert ist
- GitHub-Owner für neue Repos: `deploy.github_owner`, sonst der mit `gh` angemeldete Account
- GitHub-Sichtbarkeit: `deploy.private_repos` (Standard privat)
- Paketmanager: ausschließlich `pnpm`

Alle Werte kommen aus `~/.config/vbelt/config.json`. Lies
[references/setup.md](references/setup.md), wenn Vercel-Login, GitHub-App-Zugriff, Domain oder
`gh` nicht funktionieren.

## 1. Projekt und Slug bestimmen

1. Lies die geltenden `AGENTS.md`-Dateien.
2. Nutze den vom Nutzer genannten Slug. Fehlt er, leite ihn aus dem Verzeichnis- oder
   Repo-Namen ab.
3. Normalisiere und validiere ihn:

```bash
SKILL=~/.claude/skills/vbelt-deploy
"$SKILL/scripts/vercel-deploy.sh" normalize "<slug oder Projektname>"
```

Erlaubt sind nur kleine ASCII-Buchstaben, Ziffern und einzelne Bindestriche. Überschreibe nie
ein fremdes Vercel-Projekt: gehört `<slug>` bereits zu einem anderen Repo, stoppen und einen
anderen Slug wählen.

## 2. pnpm verbindlich machen und lokal prüfen

Das Projekt muss eine `package.json` und ein funktionierendes `build`-Script besitzen:

```bash
"$SKILL/scripts/pnpm-verify.sh" "<projektpfad>"
```

Das Skript setzt `packageManager`, importiert fremde Lockfiles nach `pnpm-lock.yaml`, entfernt
die ersetzten Lockfiles, führt `pnpm install` aus und danach vorhandene `lint`, `typecheck`,
`check`, `test` sowie zwingend `build`.

Behebe echte Fehler und wiederhole den Lauf. Umgehe keine roten Checks.

## 3. Produktionsbuild auf Vercel

Vercel erkennt Next.js, Astro, Vite, SvelteKit, Nuxt und statische Ausgaben selbst. Es gibt
kein Dockerfile, keinen Port und kein Build-Pack. Prüfe nur:

- Bei Monorepos: das Root Directory des App-Pakets (`vercel.json` oder Projekt-Einstellung
  `rootDirectory`), sonst baut Vercel das falsche Verzeichnis.
- Statische Builds: das Framework-Preset muss zum Output-Ordner passen (`dist`, `out`, `build`).
- Node-Version: `engines.node` in `package.json`, wenn das Projekt eine bestimmte braucht.
- Kein Development-Server als Produktion, keine npm- oder Yarn-Befehle in Scripts.

## 4. Secrets vor dem Commit schützen

Prüfe vor `git add`, dass mindestens `.env`, `.env.local`, `node_modules`, Build-Ausgaben und
`.vercel` ignoriert sind. Lege oder ergänze `.gitignore`. Committe niemals Secret-Werte.

Produktionsvariablen setzt du nach dem ersten `vercel link` per stdin, nie auf der Kommandozeile:

```bash
printf '%s' "<wert>" | vercel env add <KEY> production --cwd "<projektpfad>"
```

Fehlt ein zwingendes Secret, stoppe mit dem exakten Schlüsselnamen und setze keinen Platzhalter.

## 5. Commit, Repo und Push

Wähle anhand des tatsächlichen Diffs eine Conventional-Commit-Nachricht, zum Beispiel
`feat: publish <slug> landing page`:

```bash
repo=$("$SKILL/scripts/ensure-repo.sh" \
  --path "<projektpfad>" \
  --name "<repo-name>" \
  --message "<conventional commit message>")
```

Das Skript initialisiert Git bei Bedarf, legt über `gh` ein Repository unter dem konfigurierten
Owner an (leer heißt: eigener Account), committed alle geprüften Änderungen und pusht den
aktuellen Branch. Ein bestehendes `origin` muss unter diesem Owner liegen, sonst stoppt das
Skript. Mit `--owner <name>` lässt sich der Owner für einen einzelnen Aufruf überschreiben.

Wenn `gh` fehlt oder nicht authentifiziert ist, ist das ein einmaliger Setup-Blocker.

## 6. Vercel verbinden und sofort deployen

```bash
"$SKILL/scripts/vercel-deploy.sh" deploy \
  --slug "<slug>" \
  --path "<projektpfad>"
```

Das Skript legt das Vercel-Projekt `<slug>` an oder verbindet es, hängt `origin` per
`vercel git connect` an (ab jetzt deployt jeder Push automatisch), startet ein sofortiges
Produktions-Deploy aus dem Arbeitsverzeichnis, weist bei konfigurierter Domain
`<slug>.<domain>` zu und prüft die Live-URL per HTTP. Es fragt nicht erneut nach einer Freigabe.

Schlägt `vercel git connect` fehl, nennt das Skript den GitHub-Owner und den Link zur
Installation der Vercel-GitHub-App. Das ist ein einmaliger Schritt pro Owner, den nur der Nutzer
im Browser erledigen kann. Danach den Befehl wiederholen.

Die letzten Zeilen der Ausgabe sind maschinenlesbar:

```
LIVE_URL=https://...
PROJECT=<slug>
DEPLOYMENT_URL=https://...
```

## 7. Abschluss

Berichte knapp:

- Live-URL,
- Repo und gepushter Commit,
- Vercel-Projekt und Deployment-URL,
- ausgeführte pnpm-Checks,
- verbleibende Warnungen oder echte offene Punkte.

Gib zusätzlich eine Conventional-Commit-Empfehlung aus, auch wenn das Skript bereits committed
hat.
