# Einmaliges Setup

Alle Skripte lesen `~/.config/vbelt/config.json` (Vorlage: `config.example.json` im Repo). Für
den Deploy zählen die Schlüssel unter `deploy`:

| Schlüssel | Bedeutung | Standard |
|---|---|---|
| `github_owner` | Owner neuer Repos (Account oder Organisation) | leer, dann der mit `gh` angemeldete Account |
| `private_repos` | neue Repos privat anlegen | `true` |
| `vercel_scope` | Vercel-Team-Slug (`vercel teams ls`) | leer, dann der Standard-Scope der CLI |
| `domain` | eigene Domain für `<slug>.<domain>` | leer, dann `*.vercel.app` |

## Vercel CLI

```bash
npm install -g vercel
vercel login
vercel whoami
vercel teams ls
```

Persönliche Accounts können nicht als `--scope` gesetzt werden; trage den Team-Slug ein, den
`vercel teams ls` anzeigt (bei einem Hobby-Account heißt er meist `<login>s-projects`).

## GitHub

```bash
gh auth login --hostname github.com --git-protocol https --web
gh auth setup-git
```

Benötigter Scope: `repo`. Soll in einer Organisation angelegt werden, muss der Account dort
Repositories erstellen dürfen, und `deploy.github_owner` trägt den Organisationsnamen.

## Vercel-GitHub-App

`vercel git connect` funktioniert nur, wenn die Vercel-GitHub-App Zugriff auf den Owner des
Repos hat. Einmalig pro Owner:

1. <https://github.com/apps/vercel/installations/new> öffnen.
2. Den Account oder die Organisation wählen, in der die Demo-Repos liegen.
3. "All repositories" oder die betreffenden Repos freigeben.

Ohne diesen Schritt bricht `vercel-deploy.sh` mit dem Owner-Namen und diesem Link ab.

## Eigene Domain (optional)

Ohne `deploy.domain` liegt jede Demo unter dem Vercel-Produktions-Alias, meist
`<slug>.vercel.app`; bei Namenskollision hängt Vercel ein Suffix an. Das Skript liest den
tatsächlichen Alias aus `vercel project ls --json`.

Mit eigener Domain:

1. Domain im Vercel-Scope hinterlegen: `vercel domains add <domain>` oder im Dashboard.
2. Beim Registrar einen Wildcard-CNAME setzen:

| Typ | Host | Wert |
|---|---|---|
| CNAME | `*` | `cname.vercel-dns.com` |

   Alternativ die Vercel-Nameserver verwenden, dann entfällt der manuelle Record.
3. `deploy.domain` in der Konfiguration eintragen. Das Skript ruft dann
   `vercel domains add <slug>.<domain> <slug>` auf; das Zertifikat stellt Vercel selbst aus.

Prüfen: `vercel domains verify <domain>` oder `vercel domains inspect <domain>`.

## Env-Variablen

Nach dem ersten `vercel link` im Projektordner:

```bash
printf '%s' "<wert>" | vercel env add <KEY> production
vercel env ls
```

Werte nie auf die Kommandozeile schreiben und nie committen.
