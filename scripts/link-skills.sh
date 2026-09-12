#!/usr/bin/env bash
# Legt für jeden Skill unter skills/ einen Symlink in ~/.claude/skills/<name> an (macOS, Linux).
# Aufruf: scripts/link-skills.sh
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
target="$HOME/.claude/skills"
mkdir -p "$target"

for dir in "$repo_root"/skills/*/; do
  name="$(basename "$dir")"
  link="$target/$name"
  if [[ -e "$link" && ! -L "$link" ]]; then
    printf 'übersprungen  %s (existiert, kein Symlink)\n' "$name"
    continue
  fi
  ln -sfn "${dir%/}" "$link"
  printf 'verlinkt      %s -> %s\n' "$name" "${dir%/}"
done
