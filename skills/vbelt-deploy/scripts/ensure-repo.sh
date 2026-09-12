#!/usr/bin/env bash
# Bringt das Projekt nach GitHub: initialisiert Git bei Bedarf, legt das Repository an,
# committed und pusht den aktuellen Branch. Gibt auf stdout genau "owner/repo" aus.
#
# Owner: deploy.github_owner aus der Konfiguration. Ist der Wert leer, gilt der mit gh
# angemeldete Account. Sichtbarkeit: deploy.private_repos (Standard: privat).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
CONFIG="$SCRIPT_DIR/config.sh"

fail() {
  printf 'FEHLER: %s\n' "$*" >&2
  exit 1
}

project_path=""
repo_name=""
commit_message=""
owner_override=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --path) project_path="$2"; shift 2 ;;
    --name) repo_name="$2"; shift 2 ;;
    --message) commit_message="$2"; shift 2 ;;
    --owner) owner_override="$2"; shift 2 ;;
    *) fail "Unbekannte Option: $1" ;;
  esac
done

[[ -n "$project_path" ]] || fail "--path fehlt."
[[ -n "$repo_name" ]] || fail "--name fehlt."
[[ -n "$commit_message" ]] || fail "--message fehlt."
[[ "$repo_name" =~ ^[a-z0-9][a-z0-9._-]{0,99}$ ]] || fail "Ungültiger Repo-Name: $repo_name"
conventional_pattern='^(feat|fix|chore|docs|refactor|perf|test|build|ci|style)(\([^)]+\))?(!)?:[[:space:]].+'
[[ "$commit_message" =~ $conventional_pattern ]] ||
  fail "Commit-Nachricht ist nicht Conventional Commits kompatibel."

project_path="$(cd "$project_path" && pwd -P)"
home_path="$(cd "$HOME" && pwd -P)"
[[ "$project_path" != "/" && "$project_path" != "$home_path" ]] ||
  fail "Zu breiter Projektpfad: $project_path"
cd "$project_path"

command -v git >/dev/null 2>&1 || fail "git fehlt."
command -v gh >/dev/null 2>&1 || fail "gh fehlt. Installation: https://cli.github.com"
gh auth status >/dev/null 2>&1 ||
  fail "gh ist nicht authentifiziert. Einmalig: gh auth login --hostname github.com --git-protocol https --web"

github_owner="$owner_override"
if [[ -z "$github_owner" ]]; then
  github_owner="$("$CONFIG" get deploy.github_owner 2>/dev/null || true)"
fi
if [[ -z "$github_owner" ]]; then
  github_owner="$(gh api user --jq .login)"
  [[ -n "$github_owner" ]] || fail "GitHub-Login konnte nicht ermittelt werden."
fi

private_repos="$("$CONFIG" get deploy.private_repos 2>/dev/null || true)"
visibility_flag="--private"
[[ "$private_repos" == "false" ]] && visibility_flag="--public"

if [[ ! -d .git ]]; then
  git init -b main >&2
fi

while IFS= read -r secret_file; do
  [[ -z "$secret_file" ]] && continue
  if ! git check-ignore -q -- "$secret_file"; then
    fail "Secret-Datei ist nicht in .gitignore: $secret_file"
  fi
done < <(find . -maxdepth 2 -type f \
  \( -name '.env' -o -name '.env.local' -o -name '.env.*.local' \) \
  -not -path './.git/*' -print)

origin_url="$(git remote get-url origin 2>/dev/null || true)"
if [[ -z "$origin_url" ]]; then
  full_repo="$github_owner/$repo_name"
  if gh repo view "$full_repo" >/dev/null 2>&1; then
    git remote add origin "https://github.com/$full_repo.git"
  else
    gh repo create "$full_repo" "$visibility_flag" --source . --remote origin >&2
  fi
else
  full_repo="$(printf '%s' "$origin_url" |
    sed -E 's#^(git@github.com:|https://github.com/)##; s#\.git$##')"
  [[ "$full_repo" == */* ]] || fail "Origin ist kein unterstütztes GitHub-Repo: $origin_url"
  [[ "$full_repo" == "$github_owner/"* ]] ||
    fail "Origin muss unter $github_owner/ liegen, ist aber: $full_repo (deploy.github_owner in der Konfiguration anpassen oder --owner setzen)"
fi

git add -A
if ! git diff --cached --quiet; then
  git commit -m "$commit_message" >&2
fi

if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
  fail "Repository besitzt keinen Commit."
fi

branch="$(git branch --show-current)"
[[ -n "$branch" ]] || fail "Detached HEAD wird nicht automatisch deployed."
git push -u origin "$branch" >&2

printf '%s\n' "$full_repo"
