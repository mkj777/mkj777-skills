---
name: vbelt-akquise
description: Führt die vollständige Akquise-Kette für einen Betrieb in einem Durchgang aus, Demo bauen, veröffentlichen, Inhaber anschreiben. Ruft dafür nacheinander vbelt (Modus A), vbelt-deploy und den Mailversand auf und prüft nach jedem Schritt, ob weitergemacht werden darf. Nutze diesen Skill, wenn aus der Website eines Betriebs ein kontaktierter Interessent werden soll, etwa bei "mach Akquise mit dieser Seite", "bau das und schreib den an", "kompletter Durchgang", "neuer Interessent" oder wenn nur die URL eines Betriebs genannt wird, den der Nutzer gewinnen will. Deploy läuft über Vercel. Für reines Bauen ohne Veröffentlichung und Ansprache ist vbelt zuständig. Für den Coolify-Ablauf ist web-belt-akquise zuständig.
---

# VBelt Akquise

Eine Kette mit vier Phasen und einem Ziel: aus der URL eines Betriebs wird eine veröffentlichte
Demo und eine abgeschickte Mail. Dieser Skill baut und deployt nichts selbst, er ruft die
zuständigen Skills auf, prüft ihre Ergebnisse und trägt den gesammelten Kontext weiter.

## Grundregel: alles in dieser Unterhaltung

**Führe jede Phase selbst aus. Delegiere keine Phase an einen Subagenten.**

Ein Subagent startet ohne den bisherigen Kontext. Er kennt weder die Beobachtung aus der
Bestandsaufnahme, die später die erste Zeile der Mail trägt, noch die Entscheidungen aus dem Bau,
noch den Slug aus dem Deploy. Er müsste alles neu herleiten, käme zu anderen Ergebnissen und die
Mail würde von einer Seite erzählen, die so nicht gebaut wurde.

Rufe `vbelt` und `vbelt-deploy` deshalb über das Skill-Werkzeug in **dieser** Unterhaltung
auf. Ihre Anweisungen werden dadurch Teil des laufenden Kontexts, und alles, was du in Phase 1
gelernt hast, steht in Phase 4 noch zur Verfügung.

## Zweite Absicherung: RUN.md

Lange Läufe können zusammengefasst werden. Verlasse dich deshalb nicht allein auf das Gedächtnis
der Unterhaltung, sondern schreibe die Fakten mit, die spätere Phasen brauchen.

Lege dafür beim Anlegen des Projektordners `RUN.md` an und ergänze ihn am Ende **jeder** Phase,
bevor die nächste beginnt:

```markdown
# Akquise-Lauf: <Firma>

- Betrieb, Ort, Branche:
- Alte Website:
- Primäres Conversion-Ziel:
- Stärkste Beobachtung zur alten Seite (erste Zeile der Mail):
- Drei Nutzenargumente aus dem Bau (Maßnahme → warum besser):
- Ansprechpartner und Anrede:
- Kontaktadresse + wo gefunden:
- Slug / Demo-URL:
- Phase / Status:
- Message-ID der Mail:
- Nachfassen am:
```

Diese Datei ist der Übergabepunkt zwischen den Phasen. Wenn du nach einer Unterbrechung
weitermachst, lies sie zuerst, sie sagt dir, wo der Lauf steht und was schon feststeht.

## Phase 1: Bauen

Rufe `vbelt` auf und führe **Modus A** aus, die Akquise-Demo. Modus B ist hier nie richtig; er
gehört in den Zeitraum nach einer Kundenreaktion.

Übernimm aus vbelt die Bestandsaufnahme am Anfang. Sie entscheidet nicht über den Lauf: Die
Betriebe sind handverlesen, also wird gebaut. Sie liefert nur Ansatzpunkte, Übernahmefähiges und
den Ton der Mail. Steht der Betrieb bereits im Log, sag es und behandle den Kontakt als
Nachfassen.

**Gate 1, ohne diese Punkte geht es nicht weiter:**

- Build läuft fehlerfrei durch
- die Pflichten der Akquise-Demo aus `vbelt` Abschnitt 7 sind vollständig umgesetzt. Dort steht
  die verbindliche Liste; die maschinell prüfbaren Punkte bestätigt Gate 2, die übrigen bestätigst
  du hier einzeln
- der primäre Conversion-Weg funktioniert auf 390 × 844
- keine erfundenen Fakten über den Betrieb auf der Seite

Trage danach in `RUN.md` ein: Conversion-Ziel, die stärkste Beobachtung zur alten Seite und die
drei Nutzenargumente. Diese drei Felder sind das, was Phase 4 braucht, hol sie dir jetzt, solange
der Bau frisch ist.

## Phase 2: Veröffentlichen

Rufe `vbelt-deploy` auf. Übergib den Slug und den Projektpfad. Der Slug macht den Betrieb
erkennbar, ohne eine fremde Marke als eigene Domain zu inszenieren: bevorzugt `firmenname`, bei
Kollision `firmenname-ort`. Die Live-URL steht in der Zeile `LIVE_URL=` der Skript-Ausgabe.

**Gate 2, die Demo muss öffentlich funktionieren:**

```bash
~/.claude/skills/vbelt-akquise/scripts/verify-demo.sh <LIVE_URL>
```

Das Skript prüft Erreichbarkeit, gültiges TLS, HTTP 200, tatsächlichen Inhalt, `noindex`, den
Demo-Hinweis, den `tel:`-Link und das Viewport-Meta. Exit 0 heißt: die URL darf in eine Mail.

Läuft es auf einen Fehler, behebe die Ursache und prüfe erneut. Eine frisch zugewiesene eigene
Domain braucht einen Moment, bis Vercel das Zertifikat ausgestellt hat; bei einer TLS-Meldung
lohnt ein zweiter Versuch nach kurzer Wartezeit, bevor du nach der Ursache suchst.

Trage die Demo-URL in `RUN.md` ein.

## Phase 3: Mail vorbereiten

Lies `references/outreach.md` aus dem vbelt-Skill und schreibe die Mail danach.

Nimm die Bausteine aus `RUN.md`: die Beobachtung wird die erste Zeile, die drei Nutzenargumente
werden der Mittelteil, die Demo-URL steht oben. Genau dafür wurden sie in Phase 1 festgehalten.

**Gate 3, vor dem Zeigen prüfen:**

- Die Kontaktadresse stammt aus dem Impressum, ist nicht geraten und nicht aus einem Namensschema
  abgeleitet. Ist keine auffindbar: nicht senden, sondern Anruf oder Kontaktformular vorschlagen.
- Der Betrieb steht nicht bereits im Log. Das wird ausgeführt, nicht erinnert:

  ```bash
  grep -in -e "<domain-ohne-www>" -e "<firmenname>" ~/vbelt-log.md || echo "nicht im Log"
  ```

  Jede andere Ausgabe als `nicht im Log` heißt: kein zweiter Erstkontakt. Lies die gefundene Zeile,
  behandle den Fall als Nachfassen nach `outreach.md` Abschnitt 5 oder brich ab. Ein zweiter
  Erstkontakt an denselben Betrieb ist der teuerste Fehler dieser Kette.
- Die erste Zeile benennt etwas, das nur auf diese Seite zutrifft.
- Die Mail enthält keine Prozentzahlen, kein „wir", keinen Anhang, keine erfundene Vorgeschichte.
- Die Demo-URL im Text ist exakt die aus Gate 2.

Zeige dem Nutzer dann die vollständige Mail: Empfänger, Quelle der Adresse, Betreff, Text,
Signatur, Demo-URL.

## Phase 4: Senden und nachhalten

**Warte auf ausdrückliche Zustimmung.** „Senden" heißt senden; alles andere heißt überarbeiten.
Sende nie unaufgefordert, nie an mehrere Betriebe in einem Durchgang.

```bash
python3 ~/.claude/skills/vbelt/scripts/send-mail.py \
  --to "<adresse>" --subject "<betreff>" --body-file "<pfad>"
```

Die Blindkopien setzt das Skript selbst aus `mail.bcc` der Konfiguration. Sie sind das Archiv
und werden nicht unterdrückt.

Danach:

- Message-ID in `RUN.md` eintragen
- Zeile in `~/vbelt-log.md` ergänzen (Format in `outreach.md`)
- Nachfassdatum auf fünf bis sieben Tage setzen und in `RUN.md` notieren

## Abbrechen ist ein gültiges Ergebnis

Brich ab und sage klar, woran es lag, wenn keine Kontaktadresse auffindbar ist, Gate 2 wiederholt
scheitert oder der Nutzer nicht zustimmt. Der Zustand der alten Seite ist kein Abbruchgrund. Ein
abgebrochener Lauf mit klarer Begründung ist besser als eine Mail auf eine Demo, die nicht lädt.

Was schon gebaut wurde, bleibt liegen und kann später weiterverwendet werden. Halte den Grund in
`RUN.md` fest, damit derselbe Betrieb nicht versehentlich ein zweites Mal angefasst wird.

## Abschluss

Fasse zusammen:

- Betrieb, gewähltes Conversion-Ziel und was gebaut wurde
- Demo-URL und Ergebnis der Prüfung aus Gate 2
- an welche Adresse gesendet wurde, woher sie stammt, und die Message-ID
- Nachfassdatum
- was noch offen ist

Nenne außerdem, welche Phasen übersprungen oder abgebrochen wurden und warum. Ein Lauf, der bei
Phase 2 endete, wird als solcher berichtet und nicht als Erfolg dargestellt.
