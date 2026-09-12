#!/usr/bin/env bash
# Prüft eine deployte Akquise-Demo, bevor ihre URL in einer Mail landet.
# Aufruf: verify-demo.sh https://<live-url>
#
# Exit 0 = alle Pflichtprüfungen bestanden, die URL darf verschickt werden.
# Exit 1 = mindestens eine Pflichtprüfung gescheitert. Nicht verschicken.

set -uo pipefail

url="${1:-}"
if [ -z "$url" ]; then
  echo "Aufruf: $(basename "$0") <url>" >&2
  exit 2
fi

case "$url" in
  https://*) ;;
  *) echo "FEHLER  URL muss mit https:// beginnen: $url" >&2; exit 2 ;;
esac

fails=0
warns=0

ok()   { printf '  OK      %s\n' "$1"; }
bad()  { printf '  FEHLER  %s\n' "$1"; fails=$((fails + 1)); }
warn() { printf '  HINWEIS %s\n' "$1"; warns=$((warns + 1)); }

echo "Prüfe $url"

# --- Erreichbarkeit und gültiges Zertifikat (kein -k: ungültiges TLS soll scheitern) ---
err_file="$(mktemp)"
headers="$(curl -sS -I -L --max-time 20 "$url" 2>"$err_file")"
curl_status=$?
curl_err="$(cat "$err_file" 2>/dev/null)"
rm -f "$err_file"

if [ $curl_status -ne 0 ]; then
  case "$curl_err" in
    *certificate*|*SSL*) bad "TLS-Zertifikat ungültig oder fehlt, bei einer frisch zugewiesenen Domain meist noch nicht ausgestellt" ;;
    *)                   bad "nicht erreichbar: ${curl_err:-curl exit $curl_status}" ;;
  esac
  echo
  echo "Ergebnis: NICHT VERSCHICKEN ($fails Fehler)"
  exit 1
fi
ok "erreichbar, TLS-Zertifikat gültig"

status="$(printf '%s' "$headers" | awk '/^HTTP\//{code=$2} END{print code}')"
if [ "$status" = "200" ]; then
  ok "HTTP $status"
else
  bad "HTTP $status statt 200"
fi

# --- Inhalt holen ---
body="$(curl -sS -L --max-time 20 "$url" 2>/dev/null)"
bytes=${#body}
if [ "$bytes" -lt 500 ]; then
  bad "Antwort ist nur $bytes Zeichen groß, vermutlich Fehler- oder Platzhalterseite"
else
  ok "Inhalt vorhanden ($bytes Zeichen)"
fi

case "$body" in
  *"DEPLOYMENT_NOT_FOUND"*|*"NOT_FOUND"*|*"404: NOT_FOUND"*|*"404 Not Found"*|*"This deployment cannot be found"*)
    bad "Hoster-Fehlerseite statt der Demo ausgeliefert" ;;
esac

# --- noindex: Pflicht, damit die Demo der echten Seite keine Suchkonkurrenz macht ---
robots_meta="$(printf '%s' "$body" | tr 'A-Z' 'a-z' | grep -o 'name="robots"[^>]*' | head -1)"
robots_hdr="$(printf '%s' "$headers" | tr 'A-Z' 'a-z' | grep -i '^x-robots-tag' | head -1)"
if printf '%s %s' "$robots_meta" "$robots_hdr" | grep -q 'noindex'; then
  ok "noindex gesetzt"
else
  bad "kein noindex, Demo wäre indexierbar und würde der echten Seite Konkurrenz machen"
fi

# --- Demo-Kennzeichnung: Pflicht, damit die Seite nicht als offizielle Website gilt.
#     Bewusst auf die vom Skill vorgeschriebene Formulierung geprüft. Einzelne Wörter wie
#     "unverbindlich" oder "Demo" stehen auch auf regulären Geschäftsseiten und taugen nicht. ---
if printf '%s' "$body" | grep -qi 'unverbindlicher entwurf'; then
  ok "Demo-Hinweis gefunden (\"Unverbindlicher Entwurf\")"
elif printf '%s' "$body" | grep -qi 'nicht die offizielle website'; then
  ok "Demo-Hinweis gefunden (\"nicht die offizielle Website\")"
else
  bad "kein Demo-Hinweis im Wortlaut des Skills, die Seite gäbe sich als offizielle Website aus"
fi

# --- Kontaktweg: ohne tel:-Link fehlt der primäre Conversion-Pfad auf dem Telefon ---
if printf '%s' "$body" | grep -qi 'href="tel:'; then
  ok "Telefonnummer als tel:-Link verlinkt"
else
  warn "kein tel:-Link gefunden, bei lokalen Betrieben ist das der wichtigste Kontaktweg"
fi

# --- Titel ---
title="$(printf '%s' "$body" | grep -o -i '<title>[^<]*</title>' | head -1 | sed 's/<[^>]*>//g')"
if [ -n "$title" ]; then
  ok "Titel: $title"
else
  warn "kein <title> gesetzt"
fi

# --- Viewport: ohne den ist die Seite auf dem Telefon unbrauchbar ---
if printf '%s' "$body" | grep -qi 'name="viewport"'; then
  ok "Viewport-Meta gesetzt"
else
  bad "kein Viewport-Meta, die Seite skaliert auf dem Telefon nicht"
fi

echo
if [ "$fails" -eq 0 ]; then
  echo "Ergebnis: BEREIT ZUM VERSENDEN${warns:+ ($warns Hinweise)}"
  exit 0
fi
echo "Ergebnis: NICHT VERSCHICKEN ($fails Fehler, $warns Hinweise)"
exit 1
