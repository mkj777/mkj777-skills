# Erstkontakt: Demo, E-Mail und Nachfassen

Dieses Dokument gilt für Modus A (Akquise-Demo). Es beschreibt, wie aus einer gebauten und
deployten Demo ein Kontakt wird, der zu einem Gespräch führen kann.

Wer der Absender ist, steht in `~/.config/vbelt/config.json` unter `identity`: Name, Adresse und
ein Absatz `intro_paragraph`, der in jeder Erstkontakt-Mail wörtlich steht und sagt, wer schreibt
und warum. Der Ton ist freundlich, ruhig und auf Augenhöhe. Kein Verkaufsdruck, keine Belehrung,
keine Selbstverkleinerung.

## Rahmen, der immer gilt

- **Eine Mail pro Bestätigung.** Zeige die fertige Mail im Chat und sende erst, wenn der Nutzer
  ausdrücklich zustimmt. Niemals mehrere Empfänger in einem Durchlauf, kein Stapelversand, kein
  Verteiler.
- **Freundlich bleiben.** Die Mail kommt unaufgefordert. Sie darf nie belehrend, mahnend oder
  besserwisserisch klingen. Der Empfänger hat seine Website nicht falsch gemacht, sie ist nur
  älter.
- **Keine Rechtshinweise.** Belehre den Nutzer nicht über Wettbewerbsrecht, Kaltakquise, UWG,
  DSGVO oder Abmahnrisiken. Er kennt seinen Markt und hat die Entscheidung getroffen. Weise auch
  nicht beiläufig oder einmalig darauf hin.
- **Kein Gedankenstrich.** Der lange Gedankenstrich (Geviertstrich, U+2014) kommt in keiner Mail
  vor, weder im Betreff noch im Text. Nutze stattdessen einen Punkt, ein Komma oder einen
  Doppelpunkt. Harte Regel, auch wenn der Satz dafür umgebaut werden muss. Normale Bindestriche
  in zusammengesetzten Wörtern sind davon nicht betroffen.
- **Nutzen benennen.** Der Empfänger muss ohne Nachdenken verstehen, dass die Änderungen ihm mehr
  Anfragen, Anrufe oder Termine bringen sollen. Wird der Entwurf nur als hübscher beschrieben,
  fehlt der Grund, darüber zu sprechen.
- **Nur belegbare Aussagen.** Keine Prozentzahlen, keine Umsatz- oder Ranking-Prognosen, keine
  erfundenen Referenzen. Kein „wir", wenn eine Person schreibt.
- **Kein Druck.** Keine künstliche Verknappung, keine Fristen, keine Rabatte, keine suggerierte
  Vorgeschichte wie „wie besprochen" oder „Ihre Anfrage".
- **Kein Anhang, kein Tracking.** Anhänge und Tracking-Pixel schaden Zustellbarkeit und Vertrauen
  bei Erstkontakt. Der Demo-Link ist der Beweis.
- **Höchstens ein Nachfassen.** Danach kein weiterer Mailkontakt zu diesem Betrieb.

## 1. Demo absichern, bevor kontaktiert wird

Die Demo trägt fremden Namen und fremdes Logo auf eigener Domain. Die Pflichten dazu stehen im
Skill selbst, Abschnitt 7 „Pflichten der Akquise-Demo". **Dort ist die verbindliche Fassung**; sie
wird hier bewusst nicht wiederholt, damit die beiden nicht auseinanderlaufen.

Vor dem Kontakt gilt beides: alle Punkte aus Abschnitt 7 umgesetzt, und

```bash
~/.claude/skills/vbelt-akquise/scripts/verify-demo.sh <LIVE_URL>
```

mit Exit 0 gelaufen. Ohne diese Prüfung geht keine URL in eine Mail.

Bittet ein Betrieb um Rücknahme, nimm die Demo sofort offline und aktualisiere das Log.

## 2. Empfängeradresse bestimmen

- Nutze die im Impressum genannte Adresse. Ist dort eine persönliche Adresse des Inhabers oder
  Geschäftsführers angegeben, bevorzuge diese gegenüber `info@`.
- Rate niemals eine Adresse und leite keine aus dem Namensschema ab.
- Ist keine Adresse auffindbar, nur ein Kontaktformular oder nur eine Telefonnummer: keine Mail
  konstruieren. Melde das und schlage den Anruf oder das Formular vor.
- Notiere die Quelle der Adresse im Log.

## 3. Betreff

Der Betreff ist die einzige Zeile, die garantiert gelesen wird. Er entscheidet, ob die Mail
geöffnet wird, und muss deshalb genauso individuell entstehen wie die Beobachtung. Ein
austauschbarer Betreff wie `Vorschlag für Ihre Website` funktioniert, ist aber die schwächste
Variante und wird nur genommen, wenn nichts Besseres trägt.

### Formaler Rahmen

- Fünf bis neun Wörter. Kurz genug, dass er in der mobilen Vorschau vollständig sichtbar bleibt.
- Kein Ausrufezeichen, kein Fragezeichen, kein Doppelpunkt, kein Gedankenstrich, keine Emojis,
  keine Großschreibung ganzer Wörter.
- Keine Ziffern. Zahlwörter sind erlaubt und wirken konkret: `Drei konkrete Verbesserungen`.
- Kein Firmenname, wenn er den Betreff nur verlängert. `Ihre Kanzlei`, `Ihren Webauftritt` oder
  `Ihre Praxis` sind meist stärker als der ausgeschriebene Name.
- Nichts, was eine bestehende Beziehung vortäuscht: kein `Anfrage`, `Rückfrage`, `Zusammenarbeit`,
  `wie besprochen`, kein `Re:` und kein `Fwd:`.
- Keine Werbesprache und keine Versprechen: kein `mehr Umsatz`, `Top bei Google`, `unschlagbar`,
  `kostenlos`, `exklusiv`, `jetzt`.

### Wie ein Betreff entsteht

Der Betreff greift **das Thema der Mail** auf, also die Beobachtung oder den geschäftlichen
Nutzen aus {VERBESSERUNGEN}, und benennt es in der Sprache des Betriebs. Er beschreibt eine
**Idee**, einen **Vorschlag** oder ein **Potenzial**, niemals ein Ergebnis.

Zwei Bausteine, frei kombinierbar:

1. **Der Rahmen**, der die Unverbindlichkeit trägt: `Idee für`, `Vorschlag für`, `Ein konkreter
   Vorschlag für`, `Optimierungsidee für`, `Potenzial bei`, `Drei konkrete Verbesserungen für`,
   `Wie …`, `So könnte …`.
2. **Der Gegenstand**, in der Sprache der Branche. Was der Betrieb gewinnen will, heißt bei jedem
   anders: Mandantenanfragen in der Kanzlei, Patiententermine in der Praxis, Angebotsanfragen im
   Handwerk, Reservierungen in der Gastronomie, Probefahrten im Autohaus. Nimm das Wort, das der
   Betrieb selbst benutzen würde.

Der Gegenstand ist der Teil, der zwischen zwei Mails wechseln muss. Der Rahmen darf sich
wiederholen, der Gegenstand nie wörtlich.

### Beispiele

Diese acht Betreffe zeigen die angestrebte Bandbreite. Sie sind Muster, keine Liste zum Abhaken:
für jeden Betrieb entsteht ein eigener.

- `Idee für einen einfacheren digitalen Erstkontakt`
- `Vorschlag für mehr Mandantenanfragen über Ihre Website`
- `Wie Interessenten schneller zum passenden Ansprechpartner finden`
- `Drei konkrete Verbesserungen für Ihren Webauftritt`
- `Potenzial bei Ihrem digitalen Mandantenkontakt`
- `Ein konkreter Vorschlag für Ihre Kanzlei-Website`
- `Optimierungsidee für die Mandantengewinnung Ihrer Kanzlei`
- `So könnte Ihre Website Anfragen gezielter vorbereiten`

### Prüfung vor dem Senden

Ein Betreff ist brauchbar, wenn alle vier Punkte zutreffen:

- Er passt zum Inhalt dieser Mail und nicht zu jeder beliebigen anderen.
- Er nennt keinen Erfolg als sicher, sondern nur als Möglichkeit.
- Er wäre einem Betriebsinhaber nicht unangenehm, wenn ein Kollege ihn mitliest.
- Er steht so noch in keiner Zeile des Logs.

Trifft `Drei konkrete Verbesserungen` zu, müssen im Entwurf auch tatsächlich drei benannte
Verbesserungen stehen. Ein Zahlwort im Betreff ist eine Zusage an den Text darunter.

## 4. Aufbau der Mail

Die Mail besteht aus festen und variablen Teilen. Die festen Teile werden **wörtlich** übernommen,
in jeder Mail identisch. Sie sind erprobt und werden nicht umformuliert, nicht „verbessert" und
nicht an die Branche angepasst.

```
Guten Tag,

bei meiner Recherche nach {BRANCHE} in {ORT} bin ich auf Ihre Website aufmerksam
geworden. Dabei ist mir aufgefallen, dass {BEOBACHTUNG}.

Dazu habe ich unverbindlich einen möglichen neuen Entwurf erstellt:

{DEMO-URL}

{VERBESSERUNGEN}

{INTRO-ABSATZ}

Falls Ihnen der Ansatz gefällt, können wir uns gerne etwa 15 Minuten telefonisch über
den Entwurf und eine mögliche Umsetzung austauschen.

Viele Grüße

{ABSENDER-NAME}
{ABSENDER-ADRESSE}
```

`{INTRO-ABSATZ}`, `{ABSENDER-NAME}` und `{ABSENDER-ADRESSE}` kommen wörtlich aus
`identity.intro_paragraph`, `identity.name` und `identity.email` der Konfiguration. Lies die Datei
vor dem Schreiben; ist einer der drei Werte leer, stoppe und sag, welcher fehlt. Ein Platzhalter
darf nie in einer verschickten Mail stehen.

### Wörtlich feststehend

- die Anrede `Guten Tag,` ohne Namen
- der Satzanfang `bei meiner Recherche nach ... bin ich auf Ihre Website aufmerksam geworden.
  Dabei ist mir aufgefallen, dass ...`
- der Satz `Dazu habe ich unverbindlich einen möglichen neuen Entwurf erstellt:` mit der URL in
  einer eigenen Zeile darunter
- der komplette Absatz `{INTRO-ABSATZ}` aus der Konfiguration, unverändert
- der komplette Satz `Falls Ihnen der Ansatz gefällt, können wir uns gerne etwa 15 Minuten ...`
- die Signatur `Viele Grüße`, Leerzeile, Name, Adresse

Nur wenn das Impressum eindeutig eine einzelne Inhaberin oder einen einzelnen Inhaber nennt, darf
die Anrede zu `Guten Tag Frau <Nachname>,` beziehungsweise `Guten Tag Herr <Nachname>,` werden.
Im Zweifel bleibt es bei `Guten Tag,`.

### {BRANCHE} und {ORT}

Wie der Betrieb sich selbst einordnen würde, im Plural, ohne Fachjargon: `Praxen`, `Zahnarztpraxen`,
`Handwerksbetrieben`, `Restaurants`, `Kanzleien`, `Autohäusern`. Der Ort ist die Stadt oder der
Stadtteil, in dem der Betrieb sitzt.

### {BEOBACHTUNG}

Ein Satzteil, der beschreibt, **was ist**, nicht was es kostet. Konkret, überprüfbar, neutral. Er
muss auf diesen einen Betrieb zutreffen und darf in keiner zweiten Mail so vorkommen.

Gut:

- `die Telefonnummer sowie Informationen zur Telefon- und Videosprechstunde auf dem Handy erst
  nach mehreren Schritten erreichbar sind`
- `die Öffnungszeiten auf dem Handy nur über die Unterseite Kontakt zu finden sind`
- `die Speisekarte ausschließlich als PDF hinterlegt ist`

Nicht so:

- alles mit Folgenabschätzung: `dann tippt man die Nummer eher woanders ab`, `dadurch springen
  Besucher ab`, `so gehen Ihnen Anfragen verloren`. Der Nutzen gehört in {VERBESSERUNGEN}, nicht
  in die Beobachtung.
- alles Wertende: `veraltet`, `unübersichtlich`, `nicht mehr zeitgemäß`, `leider`
- Fachvokabular: `nicht responsive`, `schlechte Core Web Vitals`, `kein mobiles Menü`

### {VERBESSERUNGEN}

Drei Sätze, freundlich und sachlich:

1. Die stärkste einzelne Verbesserung, die direkt auf die Beobachtung antwortet.
2. Weitere Verbesserungen zusammengefasst, was der Besucher davon hat.
3. **Der geschäftliche Nutzen.** Dieser Satz ist Pflicht und darf nie fehlen.

Der dritte Satz ist der eigentliche Grund, warum jemand antwortet. Ohne ihn liest sich die Mail
wie ein Designvorschlag, und über Design will ein Betriebsinhaber nicht telefonieren. Er will
wissen, ob ihm das Kunden bringt. Also sag es.

Formuliere den Nutzen als Absicht, nicht als Versprechen: „sollen", „damit", „so". Keine Zahlen,
keine Prozente, keine Garantie. Die Richtung muss klar sein, die Größenordnung bleibt offen.

Brauchbare Schlusssätze:

- `So sollen mehr Besucher tatsächlich anrufen, statt die Seite wieder zu verlassen.`
- `Damit werden aus Website-Besuchern häufiger Anfragen und Termine.`
- `So bleibt weniger Interesse ungenutzt und mehr davon wird zu einem Auftrag.`
- `Damit finden mehr Interessenten den Weg zu einer Terminbuchung.`

Nicht so:

- mit Zahlen: `30 Prozent mehr Anfragen`, `verdoppelt Ihre Anfragen`
- als Garantie: `Sie bekommen dadurch mehr Kunden`, `das bringt Ihnen mehr Umsatz`
- vage: `moderner`, `professioneller`, `zeitgemäßer`. Das ist kein Nutzen, das ist Geschmack.

Weitere Regeln:

- keine Fachbegriffe
- nur beschreiben, was tatsächlich gebaut wurde
- kein Gedankenstrich

Als Muster:

```
Die Telefonnummer ist darin jederzeit mit einem Tippen erreichbar. Außerdem werden
Sprechzeiten, Leistungen und Zuständigkeiten direkt und übersichtlich angezeigt, damit
Patienten schneller die richtigen Informationen finden. So sollen mehr Besucher
tatsächlich anrufen, statt auf der Suche nach der Nummer wieder abzuspringen.
```

## 5. Nachfassen

Genau einmal, fünf bis sieben Tage nach der Erstmail, als Antwort im selben Verlauf. Kurz,
freundlich, ohne neue Argumente und ohne Nachbesserung des Angebots:

```
Guten Tag,

ich wollte kurz nachfragen, ob Sie den Entwurf ansehen konnten. Er ist weiterhin
online:

{DEMO-URL}

Falls gerade kein Interesse besteht, ist das selbstverständlich in Ordnung.

Viele Grüße

{ABSENDER-NAME}
{ABSENDER-ADRESSE}
```

Danach kein dritter Kontakt.

## 6. Versand

Gesendet wird über den eigenen Postfachzugang, nicht über einen Freemail-Dienst.

1. Zeige die vollständige Mail im Chat: Empfänger, Betreff, Körper, Signatur.
2. Nenne die Quelle der Empfängeradresse und die Demo-URL.
3. Warte auf ausdrückliche Zustimmung. „Senden" heißt senden, alles andere heißt überarbeiten.
4. Schreibe den Text in eine UTF-8-Datei und sende:

```bash
python3 ~/.claude/skills/vbelt/scripts/send-mail.py \
  --to "<adresse>" \
  --subject "<betreff>" \
  --body-file "<pfad>"
```

5. Notiere die ausgegebene Message-ID. Das Nachfassen läuft damit über `--in-reply-to` im selben
   Verlauf.
6. Trage den Eintrag im Log nach.

### Blindkopie an den Absender

Jede Mail geht automatisch zusätzlich an die Adressen aus der Liste `mail.bcc` in
`~/.config/vbelt/config.json`, üblicherweise mindestens an das eigene Postfach. Das Skript
setzt sie selbst; es ist kein Argument nötig und die Kopien dürfen bei einer echten Akquise-Mail
nicht unterdrückt werden.

Grund: Der Versand läuft direkt über SMTP und legt deshalb nichts im „Gesendet"-Ordner des
Postfachs ab. Ohne die Blindkopie gäbe es keinen Nachweis darüber, welcher Betrieb wann welchen
Text bekommen hat, weder für das Nachfassen noch bei einer Rückfrage.

Der Empfänger sieht die Blindkopie nicht: `Bcc` wird als Zustelladresse verwendet, aber vor der
Übertragung aus den Kopfzeilen entfernt. Für rein technische Tests gibt es `--no-bcc`.

### Einrichtung des Versands

Einmalig nötig, danach nie wieder. Das Skript erklärt die Schritte auch selbst, wenn nichts
konfiguriert ist.

- `~/.config/vbelt/config.json` mit `identity.name`, `identity.email`, `identity.intro_paragraph`
  sowie `mail.host`, `mail.port` (`465` für SSL, `587` für STARTTLS) und `mail.bcc`. Benutzername
  ist die Absenderadresse, sofern `mail.user` nichts anderes sagt. Vorlage: `config.example.json`
  im Skill-Repo.
- Postfach-Passwort, eine der drei Quellen in dieser Reihenfolge: Umgebungsvariable aus
  `mail.password_env` (Standard `VBELT_SMTP_PASSWORD`), Datei aus `mail.password_file` (Standard
  `~/.config/vbelt/smtp-password`, nur für den Nutzer lesbar), oder macOS-Keychain
  (`security add-generic-password -a "<adresse>" -s "vbelt-smtp" -w`).
- Prüfen mit `python3 ~/.claude/skills/vbelt/scripts/send-mail.py --check`.

Das Skript nimmt genau einen Empfänger pro Aufruf an und verweigert mehrere Adressen. Steht kein
Mailzugang zur Verfügung, lege die Mail als `OUTREACH.md` im Projektordner ab und melde das, statt
einen anderen Versandweg zu improvisieren.

## 7. Log führen

Pflege `~/vbelt-log.md` (anlegen, falls nicht vorhanden) mit einer Zeile pro Betrieb:

| Datum | Firma | Ort | Alte Website | Demo-URL | Kontakt | Status | Nächster Schritt |
|-------|-------|-----|--------------|----------|---------|--------|------------------|

Status ist einer von: `Demo gebaut`, `Mail gesendet`, `Nachgefasst`, `Antwort`, `Termin`,
`Auftrag`, `Absage`, `Offline genommen`.

Prüfe vor jedem neuen Erstkontakt, ob der Betrieb schon im Log steht. Führe die Prüfung aus, statt
dich zu erinnern:

```bash
grep -in -e "<domain-ohne-www>" -e "<firmenname>" ~/vbelt-log.md || echo "nicht im Log"
```

Jede andere Ausgabe als `nicht im Log` heißt: kein zweiter Erstkontakt an denselben Betrieb. Prüfe
die gefundene Zeile und behandle den Fall nach Abschnitt 5 als Nachfassen, falls dort noch keines
vermerkt ist.

## 8. Wenn geantwortet wird

- **Interesse oder Termin:** Wechsle in Modus B und baue die Demo zur vollständigen Website aus.
  Erst ab hier lohnen ORIGIN.md, Unterseiten, 3D-Inszenierung und die volle Recherche.
- **Rückfrage zum Preis:** Nenne keine Zahl ohne Rücksprache mit dem Nutzer. Sammle stattdessen
  Umfang, Seitenzahl, benötigte Funktionen und Termin.
- **Absage oder Bitte um Rücknahme:** Demo umgehend offline nehmen, Log aktualisieren, kein
  weiterer Kontakt.
- **Keine Antwort nach dem Nachfassen:** Log auf `Absage` setzen und die Demo offline nehmen,
  sofern sie nicht als Portfoliostück ohne fremdes Branding weiterverwendet wird.
