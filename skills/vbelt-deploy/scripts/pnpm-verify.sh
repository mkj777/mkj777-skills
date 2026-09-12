#!/usr/bin/env bash
# Macht pnpm verbindlich und prüft das Projekt lokal: install, vorhandene lint/typecheck/check/test
# Scripts und zwingend build.
set -euo pipefail

fail() {
  printf 'FEHLER: %s\n' "$*" >&2
  exit 1
}

project_path="${1:-.}"
[[ -d "$project_path" ]] || fail "Projektpfad existiert nicht: $project_path"
project_path="$(cd "$project_path" && pwd -P)"
home_path="$(cd "$HOME" && pwd -P)"
[[ "$project_path" != "/" && "$project_path" != "$home_path" ]] ||
  fail "Zu breiter Projektpfad: $project_path"

cd "$project_path"
[[ -f package.json ]] || fail "package.json fehlt."
command -v pnpm >/dev/null 2>&1 || fail "pnpm fehlt. Installation: npm install -g pnpm"

pnpm_version="$(pnpm --version)"
pnpm pkg set "packageManager=pnpm@$pnpm_version"

if [[ ! -f pnpm-lock.yaml ]]; then
  if [[ -f package-lock.json || -f npm-shrinkwrap.json || -f yarn.lock ]]; then
    printf 'Importiere vorhandenes Lockfile nach pnpm-lock.yaml ...\n'
    pnpm import
  fi
fi

if [[ -f pnpm-lock.yaml ]]; then
  rm -f package-lock.json npm-shrinkwrap.json yarn.lock
fi

pnpm install

has_script() {
  node -e 'const p=require("./package.json"); process.exit(p.scripts?.[process.argv[1]] ? 0 : 1)' "$1"
}

for script_name in lint typecheck check test; do
  if has_script "$script_name"; then
    printf 'Führe pnpm run %s aus ...\n' "$script_name"
    CI=1 pnpm run "$script_name"
  fi
done

has_script build || fail "package.json enthält kein build-Script."
printf 'Führe pnpm run build aus ...\n'
CI=1 pnpm run build

printf 'pnpm-Verifikation erfolgreich (%s).\n' "$pnpm_version"
