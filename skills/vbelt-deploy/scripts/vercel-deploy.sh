#!/usr/bin/env bash
# Veröffentlicht ein Projekt als Vercel-Projekt <slug> mit Git-Auto-Deploy.
#
# Aufruf:
#   vercel-deploy.sh normalize <name>
#   vercel-deploy.sh deploy --slug <slug> --path <projektpfad> [--repo owner/repo] [--no-prod-deploy]
#
# Ablauf von deploy:
#   1. Vercel-Projekt <slug> im konfigurierten Scope anlegen oder verbinden (vercel link)
#   2. origin des Projekts mit dem Vercel-Projekt verbinden (vercel git connect), ab dann
#      deployt jeder Push auf den Produktions-Branch automatisch
#   3. sofortiges erstes Produktions-Deploy aus dem Arbeitsverzeichnis (vercel deploy --prod)
#   4. optional eigene Domain <slug>.<deploy.domain> zuweisen
#   5. Live-URL per HTTP prüfen
#
# Ausgabe auf stdout (letzte Zeilen, maschinenlesbar):
#   LIVE_URL=https://...
#   PROJECT=<slug>
#   DEPLOYMENT_URL=https://...
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
CONFIG="$SCRIPT_DIR/config.sh"
VERCEL_APP_INSTALL_URL="https://github.com/apps/vercel/installations/new"

fail() {
  printf 'FEHLER: %s\n' "$*" >&2
  exit 1
}

note() {
  printf '%s\n' "$*" >&2
}

normalize_slug() {
  local raw="$1"
  local slug
  slug="$(printf '%s' "$raw" |
    sed -e 's/ä/ae/g; s/Ä/Ae/g; s/ö/oe/g; s/Ö/Oe/g; s/ü/ue/g; s/Ü/Ue/g; s/ß/ss/g' |
    tr '[:upper:]' '[:lower:]' |
    sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//; s/-+/-/g')"
  [[ -n "$slug" ]] || fail "Slug ist nach der Normalisierung leer: $raw"
  [[ ${#slug} -le 63 ]] || fail "Slug ist länger als 63 Zeichen: $slug"
  [[ "$slug" =~ ^[a-z0-9]([a-z0-9-]*[a-z0-9])?$ ]] || fail "Ungültiger Slug: $slug"
  printf '%s\n' "$slug"
}

require_tools() {
  command -v vercel >/dev/null 2>&1 || fail "vercel fehlt. Installation: npm install -g vercel"
  command -v git >/dev/null 2>&1 || fail "git fehlt."
  command -v curl >/dev/null 2>&1 || fail "curl fehlt."
  command -v node >/dev/null 2>&1 || fail "node fehlt."
}

vercel_scope_args() {
  if [[ -n "$scope" ]]; then
    printf -- '--scope\n%s\n' "$scope"
  fi
}

cmd_normalize() {
  [[ $# -eq 1 ]] || fail "Aufruf: vercel-deploy.sh normalize <name>"
  normalize_slug "$1"
}

production_url_for_project() {
  # Liest latestProductionUrl aus `vercel project ls --json`. Leer, wenn unbekannt.
  local name="$1"
  local args=()
  while IFS= read -r line; do args+=("$line"); done < <(vercel_scope_args)
  vercel project ls --json "${args[@]}" 2>/dev/null |
    node -e '
      let data = "";
      process.stdin.on("data", c => data += c);
      process.stdin.on("end", () => {
        const start = data.indexOf("{");
        if (start < 0) process.exit(0);
        let json;
        try { json = JSON.parse(data.slice(start)); } catch { process.exit(0); }
        const p = (json.projects || []).find(x => x.name === process.argv[1]);
        if (p && p.latestProductionUrl) console.log(p.latestProductionUrl);
      });
    ' "$name" || true
}

cmd_deploy() {
  local slug="" project_path="" repo="" prod_deploy=1
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --slug) slug="$2"; shift 2 ;;
      --path) project_path="$2"; shift 2 ;;
      --repo) repo="$2"; shift 2 ;;
      --no-prod-deploy) prod_deploy=0; shift ;;
      *) fail "Unbekannte Option: $1" ;;
    esac
  done
  [[ -n "$slug" ]] || fail "--slug fehlt."
  [[ -n "$project_path" ]] || fail "--path fehlt."
  slug="$(normalize_slug "$slug")"
  [[ -d "$project_path" ]] || fail "Projektpfad existiert nicht: $project_path"
  project_path="$(cd "$project_path" && pwd -P)"

  require_tools
  scope="$("$CONFIG" get deploy.vercel_scope 2>/dev/null || true)"
  domain="$("$CONFIG" get deploy.domain 2>/dev/null || true)"

  vercel whoami >/dev/null 2>&1 || fail "vercel ist nicht angemeldet. Einmalig: vercel login"

  cd "$project_path"
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "Kein Git-Repository: $project_path (zuerst ensure-repo.sh ausführen)"
  origin_url="$(git remote get-url origin 2>/dev/null || true)"
  [[ -n "$origin_url" ]] || fail "Kein origin-Remote. Zuerst ensure-repo.sh ausführen."
  if [[ -z "$repo" ]]; then
    repo="$(printf '%s' "$origin_url" | sed -E 's#^(git@github.com:|https://github.com/)##; s#\.git$##')"
  fi
  owner="${repo%%/*}"
  branch="$(git branch --show-current)"
  [[ -n "$branch" ]] || fail "Detached HEAD wird nicht deployed."
  if [[ -n "$(git status --porcelain)" ]]; then
    fail "Arbeitsverzeichnis hat uncommittete Änderungen. Zuerst ensure-repo.sh ausführen."
  fi

  local sargs=()
  while IFS= read -r line; do sargs+=("$line"); done < <(vercel_scope_args)

  # 1. Projekt anlegen oder verbinden
  note "Verbinde Vercel-Projekt '$slug'${scope:+ im Scope $scope} ..."
  if ! vercel link --yes --project "$slug" "${sargs[@]}" >&2; then
    note "vercel link schlug fehl, lege Projekt an ..."
    vercel project add "$slug" "${sargs[@]}" >&2 || fail "Vercel-Projekt '$slug' konnte nicht angelegt werden."
    vercel link --yes --project "$slug" "${sargs[@]}" >&2 || fail "vercel link schlug auch nach dem Anlegen fehl."
  fi
  [[ -f .vercel/project.json ]] || fail ".vercel/project.json fehlt nach vercel link."
  if ! git check-ignore -q .vercel; then
    printf '\n.vercel\n' >> .gitignore
    note ".vercel in .gitignore aufgenommen."
  fi
  # vercel link schreibt .vercel selbst in die .gitignore; diese eine Änderung wird committet,
  # alles andere bleibt ein Fehler, weil sonst das Git-Deploy einen anderen Stand baut.
  dirty="$(git status --porcelain)"
  if [[ -n "$dirty" ]]; then
    if [[ "$dirty" == " M .gitignore" ]]; then
      git add .gitignore
      git commit -q -m "chore: ignore .vercel" >&2
      git push -q origin "$branch" >&2
      note ".gitignore-Änderung von vercel link committet und gepusht."
    else
      fail "vercel link hat unerwartete Änderungen hinterlassen: $dirty"
    fi
  fi

  # 2. Git-Anbindung
  note "Verbinde $repo mit dem Vercel-Projekt (Auto-Deploy bei Push) ..."
  connect_out="$(vercel git connect --yes "${sargs[@]}" 2>&1)" && connect_ok=1 || connect_ok=0
  printf '%s
' "$connect_out" >&2
  # Neuere CLIs verbinden das Repo schon bei vercel link; "already connected" endet dann mit Exit 1.
  if [[ $connect_ok -eq 0 ]] && ! printf '%s' "$connect_out" | grep -qi "already connected"; then
    fail "vercel git connect schlug fehl. Die Vercel-GitHub-App braucht Zugriff auf '$owner': $VERCEL_APP_INSTALL_URL (dort '$owner' wählen und das Repository freigeben), danach erneut ausführen."
  fi

  # 3. Erstes Produktions-Deploy
  deployment_url=""
  if [[ $prod_deploy -eq 1 ]]; then
    note "Starte Produktions-Deploy ..."
    deployment_url="$(vercel deploy --prod --yes "${sargs[@]}" 2> >(cat >&2))" ||
      fail "vercel deploy schlug fehl."
    deployment_url="$(printf '%s' "$deployment_url" | grep -Eo 'https://[^[:space:]]+' | tail -n 1 || true)"
    [[ -n "$deployment_url" ]] || fail "vercel deploy hat keine Deployment-URL ausgegeben."
  fi

  # 4. Live-URL bestimmen
  live_url=""
  if [[ -n "$domain" ]]; then
    fqdn="$slug.$domain"
    note "Weise Domain $fqdn zu ..."
    vercel domains add "$fqdn" "$slug" "${sargs[@]}" >&2 ||
      fail "Domain $fqdn konnte nicht zugewiesen werden. Ist $domain im Vercel-Scope hinterlegt und der Wildcard-CNAME gesetzt? Siehe references/setup.md."
    live_url="https://$fqdn"
  else
    live_url="$(production_url_for_project "$slug")"
    [[ -n "$live_url" ]] || live_url="$deployment_url"
  fi
  [[ -n "$live_url" ]] || fail "Keine Live-URL ermittelbar (weder Produktions-Alias noch Deployment-URL)."

  # 5. HTTP-Check, bei frischer Domain kurz warten
  note "Prüfe $live_url ..."
  code="000"
  for attempt in 1 2 3 4 5 6; do
    code="$(curl -sS -L -o /dev/null -w '%{http_code}' --max-time 25 "$live_url" 2>/dev/null || printf '000')"
    [[ "$code" == "200" ]] && break
    sleep 10
  done
  [[ "$code" == "200" ]] || fail "Live-URL antwortet mit HTTP $code: $live_url"

  printf 'LIVE_URL=%s\n' "$live_url"
  printf 'PROJECT=%s\n' "$slug"
  [[ -n "$deployment_url" ]] && printf 'DEPLOYMENT_URL=%s\n' "$deployment_url"
  return 0
}

scope=""
case "${1:-}" in
  normalize) shift; cmd_normalize "$@" ;;
  deploy) shift; cmd_deploy "$@" ;;
  *) fail "Aufruf: vercel-deploy.sh normalize <name> | deploy --slug <slug> --path <projektpfad>" ;;
esac
