---
name: vbelt-lead
description: Holt den Lead, an dem gebaut wird, und führt seinen Zustand mit. Nutze diesen Skill, wenn vbelt oder vbelt-akquise ohne mitgelieferte Website aufgerufen wird, kein Link, kein Screenshot, kein Export im Auftrag, und ebenso, wenn ein Lead über die konfigurierte Lead-API reserviert, auf "wird gebaut" gesetzt, bei Abbruch freigegeben oder nach verifiziertem Deploy als gebaut gemeldet werden muss. Ohne lead.api_base in ~/.config/vbelt/config.json ist der Lead-Modus nicht verfügbar. Für den Coolify-Ablauf ist web-belt-lead zuständig.
---

# VBelt Lead

Der Claim steht am Anfang eines Laufs, lange vor dem Deploy; die `built`-Meldung schließt ihn nach
der Live-Verifikation ab. Die Veröffentlichung dazwischen macht `vbelt-deploy`.

Nutze die Lead-API als exklusiven Arbeitsvertrag für einen programmatischen `vbelt`-Lauf. Der
Ablauf ist `claim → bauen und verifizieren → built`; bei Abbruch gilt `release`. `claim` reserviert
den Lead sofort, damit ein kurz danach gestarteter zweiter Lauf einen anderen Lead erhält.

Die API versendet nichts. Ein Entwurf bleibt Material für ein Gespräch, das ein Mensch führt.

## Verbindlicher Ablauf

1. Wenn keine Website, kein Screenshot und kein Export im Auftrag steckt, sende **unmittelbar vor
   Beginn der Arbeit** `POST /api/build/claim` mit dem Standard `limit=1`.
2. Ist `items` leer, beende den Lauf mit „aktuell nichts zu bauen“. Erfinde keinen Lead.
3. Speichere `items[0].id` und arbeite nur an diesem reservierten Lead. Sein `lead_status` ist nun
   `building`. Hole während desselben Laufs keinen Vorrat weiterer Leads.
4. Nutze die volle Lead-Ansicht als Bestand für Recherche und Bau. Übermittle `contacts` mit
   `is_personal_data: true` nicht ungefragt an Cloud-LLMs.
5. Nach erfolgreichem Deploy, öffentlicher Prüfung und bestandenem `verify-demo.sh`-Gate sende
   `POST /api/build/{id}/built` mit der verifizierten URL und einer knappen Beschreibung.
6. Kann der Lauf vor `built` nicht erfolgreich abgeschlossen werden, sende sofort
   `POST /api/build/{id}/release`. Das gilt auch bei einem bewusst verworfenen Entwurf oder einem
   nicht behebbaren Bau-/Deployfehler.

**Nie zuerst `GET /api/build/queue` lesen und daraus bauen.** `queue` reserviert nichts. Zwei Läufe,
die aus derselben Queue-Zeile bauen, produzieren dieselbe Website doppelt.

## Adresse und Zugriff

Die Basis-URL steht in `~/.config/vbelt/config.json` unter `lead.api_base`. Lies sie vor dem
ersten Aufruf:

```bash
node -e 'const c=require(require("os").homedir()+"/.config/vbelt/config.json");console.log(c.lead?.api_base||"")'
```

Ist der Wert leer, ist der Lead-Modus nicht eingerichtet: sag das, brich diesen Skill ab und
verlange im Auftrag eine Website (URL, Screenshot oder Export). Erfinde keine Adresse.

Die vier `/api/build`-Routen erwarten keine Anmeldung, weil der Dienst nur in einem privaten
Netz erreichbar ist. Wird die App öffentlich erreichbar, muss dieser Router serverseitig hinter
eine Anmeldung. Ist `lead.api_token` gesetzt, sende ihn als `Authorization: Bearer`.

## Routen

| Route | Wirkung |
| --- | --- |
| `POST /api/build/claim` | Reserviert interessante Leads atomar und setzt sie auf `building`. |
| `GET /api/build/queue` | Zeigt dasselbe Fenster ohne Zustandsänderung. Nur Monitoring. |
| `POST /api/build/{id}/release` | Gibt einen noch reservierten Lead nach `interesting` zurück. |
| `POST /api/build/{id}/built` | Setzt den Lead auf `built` und protokolliert URL/Notiz als Bau-Agent. |

`claim` und `queue` akzeptieren `limit` (Standard `1`, Bereich 1–10) und `offset` (Standard `0`,
mindestens 0). Nutze im normalen Lauf `POST /claim` ohne Parameter. `offset` überspringt einen
wartenden Lead unangetastet; es ersetzt nicht `release` nach einem Claim.

Antwort von `claim`:

```jsonc
{
  "items": [{ "id": 4711, "lead_status": "building" }],
  "total": 36,
  "limit": 1,
  "offset": 0
}
```

`total` zählt die danach noch wartenden Leads. Ein Claim verfällt nach sechs Stunden und wird dann
automatisch auf `interesting` zurückgelegt. Das ist Absturzsicherung, kein normaler Abschlussweg.
Erneutes Abholen verlängert die Reservierung nicht.

### Lead-Daten

Die Items entsprechen der vollen Lead-Ansicht. Relevant sind Identität und Ort (`name`, Branche,
Adresse), Bestand (`domains`, `website_state`, `audit`, `signals`, `scores`), Ansatzpunkte
(`needs`), Kontext (`notes`, `comments`, `events`, Funnel-Felder) und personenbezogene
`contacts[].is_personal_data`.

Die Queue teilt das Export-Tor: gesperrte Firmen, offene Insolvenz-/Liquidationsstopps,
weggemergte Dubletten und andere Funnel-Stufen werden nicht ausgegeben. Die KI erfindet keinen
eigenen Auswahlfilter; ein Mensch bestimmt durch `interesting`, was gebaut werden darf.

### Freigeben

```http
POST /api/build/4711/release
```

`200` liefert `released` und den vollständigen Lead. `released: false` ist kein Fehler: Die
Reservierung kann abgelaufen oder der Lead von einem Menschen weiterbewegt worden sein. Nicht
versuchen, einen späteren Funnel-Status zurückzuziehen. Eine unbekannte Firma liefert `404`.

### Als gebaut melden

```jsonc
{
  "url": "https://baeckerei-mueller.vercel.app",
  "note": "Entwurf: Startseite, Leistungen und Kontakt; mobil geprüft"
}
```

`url` ist optionaler Text bis 1000 Zeichen, `note` optionaler Text bis 2000 Zeichen; unbekannte
Body-Felder liefern `422`. Für `vbelt` beide Werte nach dem verifizierten Deploy mitsenden.
Die Antwort enthält `changed` und den vollständigen Lead. Wiederholtes Melden ist erlaubt und kann
`changed: false` ergeben; ein weiterer Kommentar wird trotzdem protokolliert.

`built` ist nur aus `new`, `interesting`, `building` oder bereits `built` erlaubt. Ab `contacted`
sowie aus `declined` liefert die API `409`, ebenso bei weggemergten Dubletten. Dann nicht weiter
retryen oder den Funnel zurückziehen. `404` bedeutet unbekannte Firma.

## Robustes Beispiel

```python
import json, os
import httpx

with open(os.path.expanduser("~/.config/vbelt/config.json"), encoding="utf-8") as handle:
    LEAD_API_BASE = (json.load(handle).get("lead") or {}).get("api_base")
if not LEAD_API_BASE:
    raise SystemExit("lead.api_base fehlt in ~/.config/vbelt/config.json")

with httpx.Client(base_url=LEAD_API_BASE) as http:
    page = http.post("/api/build/claim").raise_for_status().json()
    if not page["items"]:
        raise SystemExit("Aktuell nichts zu bauen")

    lead = page["items"][0]
    try:
        entwurf = baue_und_verifiziere(lead)
        http.post(
            f"/api/build/{lead['id']}/built",
            json={"url": entwurf.url, "note": entwurf.beschreibung},
        ).raise_for_status()
    except Exception:
        http.post(f"/api/build/{lead['id']}/release").raise_for_status()
        raise
```

Für Monitoring darf `GET /api/build/queue` verwendet werden. Aktuelle Schemas stehen unter
`GET /openapi.json` beziehungsweise `/docs`, Abschnitt `build`.

## Abschlusscheck

- Der erste schreibende Schritt war `POST /api/build/claim`, nicht `GET /queue`.
- Es wurde genau ein Lead reserviert und ausschließlich dessen ID verwendet.
- Bei Erfolg wurde erst nach Live-Verifikation `built` mit URL und Notiz gesendet.
- Bei jedem Abbruch vor `built` wurde `release` versucht.
- Es wurde keine Nachricht versendet und kein personenbezogener Kontakt unnötig weitergegeben.
