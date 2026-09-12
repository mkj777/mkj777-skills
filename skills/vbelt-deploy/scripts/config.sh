#!/usr/bin/env bash
# Liest einen Wert aus der vbelt-Konfiguration (Standard: ~/.config/vbelt/config.json).
#
# Aufruf:  config.sh get <pfad>            z. B. config.sh get deploy.github_owner
#          config.sh require <pfad>        wie get, bricht aber ab, wenn der Wert fehlt
#          config.sh path                  gibt den Pfad der Konfigurationsdatei aus
#
# null, fehlende Schlüssel und leere Strings ergeben eine leere Ausgabe. Listen werden
# kommagetrennt ausgegeben. Der Pfad zur Datei lässt sich mit VBELT_CONFIG überschreiben.
set -euo pipefail

CONFIG_FILE="${VBELT_CONFIG:-$HOME/.config/vbelt/config.json}"

fail() {
  printf 'FEHLER: %s\n' "$*" >&2
  exit 1
}

read_key() {
  [[ -f "$CONFIG_FILE" ]] ||
    fail "Konfiguration fehlt: $CONFIG_FILE (Vorlage: config.example.json im Skill-Repo)"
  command -v node >/dev/null 2>&1 || fail "node fehlt, wird zum Lesen der Konfiguration gebraucht."
  node -e '
    const fs = require("fs");
    const [file, key] = process.argv.slice(1);
    let cfg;
    try { cfg = JSON.parse(fs.readFileSync(file, "utf8")); }
    catch (e) { console.error("FEHLER: " + file + " ist kein gültiges JSON: " + e.message); process.exit(1); }
    const value = key.split(".").reduce((o, k) => (o == null ? undefined : o[k]), cfg);
    if (value == null || value === "") process.exit(0);
    if (Array.isArray(value)) { console.log(value.join(",")); process.exit(0); }
    if (typeof value === "object") { console.log(JSON.stringify(value)); process.exit(0); }
    console.log(String(value));
  ' "$CONFIG_FILE" "$1"
}

case "${1:-}" in
  get)
    [[ -n "${2:-}" ]] || fail "config.sh get <pfad>"
    read_key "$2"
    ;;
  require)
    [[ -n "${2:-}" ]] || fail "config.sh require <pfad>"
    value="$(read_key "$2")"
    [[ -n "$value" ]] || fail "Konfigurationswert fehlt: $2 in $CONFIG_FILE"
    printf '%s\n' "$value"
    ;;
  path)
    printf '%s\n' "$CONFIG_FILE"
    ;;
  *)
    fail "Aufruf: config.sh get|require <pfad> oder config.sh path"
    ;;
esac
