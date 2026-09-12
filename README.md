# mkj777-skills

Eigene Skills für Claude Code und andere Agenten, in einem Repository. Zwei Familien:

- **vbelt**: baut aus einer veralteten Unternehmenswebsite eine bessere und veröffentlicht sie
  über Vercel mit Git-Auto-Deploy. Die Vercel-Fassung der web-belt-Kette; beide können
  nebeneinander installiert sein, die Namen und Trigger sind getrennt.
- **web-audit**: Performance- und Barrierefreiheits-Audit gegen deployte URLs mit Baseline,
  Fix-Loop und Nachmessen.

| Skill | Zweck | Ruft auf | Wird aufgerufen von |
|---|---|---|---|
| [`vbelt-akquise/`](skills/vbelt-akquise/) | ganze Akquise-Kette in einem Durchgang, vier Gates dazwischen | `vbelt`, `vbelt-deploy`, Mailversand | |
| [`vbelt/`](skills/vbelt/) | bauen, in Modus A plus Deploy und Erstkontakt-Mail | `vbelt-design`, `vbelt-imagegen`, `vbelt-lead`, `vbelt-deploy` | `vbelt-akquise` |
| [`vbelt-design/`](skills/vbelt-design/) | gestalterische Richtung festlegen | `vbelt-imagegen` (als Briefing) | `vbelt` |
| [`vbelt-imagegen/`](skills/vbelt-imagegen/) | ein Bild pro Abschnitt erzeugen | | `vbelt`, `vbelt-design` |
| [`vbelt-lead/`](skills/vbelt-lead/) | Lead reservieren, freigeben, als gebaut melden | | `vbelt` |
| [`vbelt-deploy/`](skills/vbelt-deploy/) | als Vercel-Projekt veröffentlichen, Git verbinden, Live-URL prüfen | | `vbelt`, `vbelt-akquise` |
| [`web-audit/`](skills/web-audit/) | messen, Findings priorisieren, fixen, nachmessen | Chrome-DevTools-MCP, Lighthouse | |

`vbelt-imagegen` ist `imagegen-frontend-web` aus dem Taste-Skill von Leonxlnx unter dem
Namensschema dieses Repos: <https://github.com/Leonxlnx/taste-skill/tree/main/skills/imagegen-frontend-web>

## Installation

Windows (Junctions nach `~/.claude/skills/`):

```powershell
git clone https://github.com/mkj777/mkj777-skills.git
pwsh mkj777-skills/scripts/link-skills.ps1
```

macOS und Linux (Symlinks):

```bash
git clone https://github.com/mkj777/mkj777-skills.git
mkj777-skills/scripts/link-skills.sh
```

Oder über die Skills-CLI, die `skills/<name>/SKILL.md` selbst findet:

```bash
npx skills add mkj777/mkj777-skills -a claude-code -g
```

## Konfiguration

Alles Persönliche liegt außerhalb des Repos in `~/.config/vbelt/config.json`. Vorlage:
[`config.example.json`](config.example.json).

| Abschnitt | Schlüssel | Bedeutung |
|---|---|---|
| `identity` | `name`, `email`, `intro_paragraph` | Absender der Akquise-Mails und der Absatz, der in jeder Erstkontakt-Mail steht |
| `mail` | `host`, `port`, `user`, `bcc`, `password_env`, `password_file`, `keychain_service` | SMTP-Zugang; das Passwort kommt aus Umgebungsvariable, Datei oder macOS-Keychain, nie aus der Config |
| `deploy` | `github_owner`, `private_repos`, `vercel_scope`, `domain` | Owner neuer Repos (leer = eigener Account), Vercel-Team, optionale eigene Domain für `<slug>.<domain>` |
| `lead` | `api_base`, `api_token` | Lead-API für unbeaufsichtigte Läufe; leer = Lead-Modus aus |

Einmalig für den Deploy: `vercel login`, `gh auth login`, und die Vercel-GitHub-App für den
Owner freischalten. Details in [`skills/vbelt-deploy/references/setup.md`](skills/vbelt-deploy/references/setup.md).

`web-audit` braucht den Chrome-DevTools-MCP:

```bash
claude mcp add --scope user chrome-devtools -- npx -y chrome-devtools-mcp@latest
```

Lighthouse wird bei der ersten Messung über `npx` geladen, keine globale Installation nötig.

## Aufbau eines Skills

```
skills/<name>/
  SKILL.md              Frontmatter mit name und description, dann die Anweisungen
  agents/openai.yaml    Anzeigename und Standard-Prompt für andere Harnesses
  references/           Nachschlagetexte, aus SKILL.md relativ verlinkt
  scripts/              Bash, Python oder Node; ermitteln ihr Verzeichnis selbst
```

Kein Gedankenstrich in diesem Repo, in keiner Datei. Ein Komma, ein Doppelpunkt, ein Punkt oder
eine Klammer deckt jeden Fall ab.
