---
name: vbelt
description: Baut aus einer bestehenden, veralteten Unternehmenswebsite eine moderne Neufassung, als schnelle Akquise-Demo mit Deploy und vorbereiteter Erstkontakt-Mail oder als vollständigen Website-Ausbau. Nutze diesen Skill, wenn du anhand einer URL, eines Screenshots oder eines Website-Exports selbstständig Unternehmen, Branche, Zielgruppen, Angebot und lokalen Markt verstehen und daraus eine bessere Website für Kundengewinnung, Terminbuchung, Anfragen oder Verkäufe umsetzen sollst. Ebenso bei Formulierungen wie "bau mir daraus eine Demo", "Akquise-Seite für diesen Betrieb", "modernisiere diese Website", "schreib dem Inhaber dazu eine Mail". Geeignet für Website-Modernisierung, Redesign, Relaunch und branchengerechte Conversion-Optimierung, auch wenn außer der bestehenden Website kein Briefing vorliegt. Veröffentlicht über Vercel (vbelt-deploy). Für den Coolify-Ablauf ist web-belt zuständig.
---

# VBelt

Aus einer veralteten Unternehmenswebsite eine bessere bauen, entweder als Arbeitsprobe, mit der
der Betrieb angesprochen wird, oder als vollständige Website für einen Kunden, der bereits
zugesagt hat.

Der Skill wird von einem selbstständigen Einzelentwickler eingesetzt, der sich gerade aufbaut.
Der Engpass ist Zeit pro Interessent, nicht Ambition. Baue deshalb nur so tief, wie die aktuelle
Stufe es rechtfertigt.

## Zwei Modi

**Modus A, Akquise-Demo (Standard).** Eine Seite mit wenigen, dafür vollständig gestalteten
Abschnitten, öffentlich erreichbar, plus vorbereitete Erstkontakt-Mail. Ziel ist eine Antwort.

**Modus B, Vollausbau.** Dieselbe Seite auf alle nötigen Unterseiten ausgedehnt, mit voller
Recherche, Produktinszenierung und `docs/ORIGIN.md`. Läuft erst, wenn Interesse oder eine Zusage
vorliegt, oder wenn der Nutzer es ausdrücklich verlangt.

**Der Unterschied ist die Fläche, nicht der Maßstab.** Beide Modi bauen nach `vbelt-design` in voller
Tiefe: Bau-Erklärung, gemessene Kontraste, komponierter Hero, Auftritt und Übergabe,
Navigationsmodell, gestalteter Footer, ein Set-Piece, wenn die Richtung es trägt. Die Demo ist das
gesamte Argument und das Einzige, was der Empfänger je zu sehen bekommt, eine halb gestaltete Demo
argumentiert gegen sich selbst.

| | Modus A | Modus B |
|---|---|---|
| Recherche | Angebot, Zielgruppe, Ort, kurzer Wettbewerbsblick | vollständig nach Abschnitt 3 |
| Fläche | eine Seite, wenige Abschnitte | alle nötigen Seiten |
| Gestaltungsmaßstab | voll, nach `vbelt-design` | derselbe, zusätzlich über alle Seiten geprüft |
| Bilder | wenige, jedes für seinen Platz komponiert | vollständige Bildstrategie über alle Seiten |
| Motion | Auftritt, Übergabe, ein Set-Piece wenn es trägt | dasselbe, plus Produktinszenierung |
| 3D | nur mit vorhandenen, geklärten Assets | ja, wo es das Produkt erklärt |
| Optimistic UI | nur bei echter Interaktion | ja |
| Skeleton Screens | für Bilder und Medien | vollständig |
| docs/ORIGIN.md | nein | ja |
| Deploy | ja, immer | nur auf Ansage |
| Erstkontakt-Mail | ja | nein |

Bleibe in Modus A, bis der Nutzer wechselt oder ein Betrieb geantwortet hat.

**Wird die Zeit knapp, streiche einen Abschnitt, nicht den Maßstab.** Vier fertig gestaltete
Abschnitte schlagen acht hingelegte. Zieht sich ein Lauf in Modus A weit über eine Stunde, war die
Abschnittsliste zu lang: kürze sie, liefere die kürzere Seite vollständig, und sage, was du
weggelassen hast.

## Zusammenspiel mit anderen Skills

Dieser Skill regelt Recherche, Positionierung, Conversion-Strategie, Implementierung, Erstkontakt
und Herkunftsdokumentation. Alles andere wird delegiert, nicht hier dupliziert:

- **Alles Gestalterische, Richtung, Typografie, Raster, Farbe, Komposition, Navigation, Motion,
  Favicon:** `vbelt-design`, auch bei deutschsprachigen Projekten.
- **Bildkonzeption und Bildgenerierung:** `vbelt-imagegen`.
- **Veröffentlichung als Vercel-Projekt `<slug>` (Live-URL aus `LIVE_URL=`):** `vbelt-deploy`.
- **Lead unmittelbar vor Baubeginn reservieren, bei Abbruch freigeben und nach erfolgreichem Bau
  melden, wenn keine Website im Auftrag steckt:** `vbelt-lead`.

Übergib den hier erarbeiteten Rahmen: Branche, Preispositionierung, Markenbestand, Zielgruppe und
Conversion-Ziel. Ist ein Skill nicht verfügbar, wende sein Prinzip sinngemäß an, aber baue in
vbelt keine eigene Designregel-Sammlung auf.

## Arbeitsprinzip

- Frage nicht nach Texten, Assets, Stilrichtungen oder Zielgruppen, wenn sie zuverlässig aus
  Website und öffentlicher Recherche ableitbar sind.
- Stoppe nicht bei Audit, Konzept, Wireframe oder Empfehlungen. Implementiere im verfügbaren
  Workspace.
- Triff begründete Annahmen und kennzeichne nur solche, die fachlich bestätigt werden müssen.
- Erfinde keine Leistungen, Produkte, Preise, Referenzen, Bewertungen, Zertifikate, Mitarbeiter,
  Standorte, Öffnungszeiten, Garantien, Kennzahlen oder rechtlichen Aussagen. Das gilt in einer
  öffentlich erreichbaren Demo doppelt: dort stünde eine erfundene Aussage über einen fremden
  Betrieb im Netz.
- Optimiere auf ein klares Geschäftsziel, nicht auf maximale Effektmenge.
- Vermarkte jedes Angebot über das *Warum es besser ist*, nicht über Selbstlob.
- Plane Mobile als Hauptfall ein. Eine Seite, die nur am Desktop funktioniert, ist nicht geliefert.
- Bewahre bestehende Nutzeränderungen und arbeite nicht destruktiv.

## 1. Modus, Eignung und Arbeitsumgebung klären

1. Extrahiere URL, Unternehmensname und Standort aus Link, Screenshot, Export oder Dateien. **Liegt
   keins davon vor**, kein Link, kein Screenshot, kein Export im Auftrag , , frage nicht danach,
   sondern hole den Fall selbst: Nutze `vbelt-lead` und reserviere **unmittelbar vor Beginn
   dieses Laufs** genau einen Lead mit `POST /api/build/claim`. `GET /api/build/queue` ist nur zum
   Hinsehen und darf den Claim nicht ersetzen. Merke dir die Lead-ID; sie wird bei Abbruch zum Freigeben und
   nach dem Deploy in Abschnitt 9 zum Melden gebraucht. Starte ohne erfolgreichen Claim keinen Bau.
2. Bestimme den Modus: Standard ist A. Modus B nur auf Ansage oder nach Kundenreaktion.
3. Verschaffe dir in Modus A kurz ein Bild vom Ausgangszustand. Das ist Bestandsaufnahme, keine
   Eignungsprüfung: Die Betriebe sind bereits ausgewählt, brich nicht ab und stelle die Auswahl
   nicht in Frage. Halte fest, was du siehst, und nutze es für Ansatzpunkte, Übernahme und Ton:
   - Wie aktuell, gepflegt und mobil brauchbar die bestehende Seite ist, daraus ergibt sich, wo
     der Hebel liegt.
   - Welche Kontaktmöglichkeiten und welches Impressum auffindbar sind (Adressquelle für
     Abschnitt 10). Fehlt beides, baue trotzdem und melde es beim Erstkontakt.
   - Ob der Betrieb aktiv wirkt und was auf seinen aktuellen Stand hindeutet.
   - Ob eine betreuende Agentur erkennbar ist, das beeinflusst den Ton der Mail, nicht das Ob.
   - Ob der Betrieb schon im Log (Abschnitt 10) steht. Wenn ja, sag es und behandle den Kontakt
     als Nachfassen statt als Erstkontakt.
4. Lies Repo-Anweisungen und untersuche den Workspace, bevor du Dateien änderst.
5. Nutze bei einem bestehenden Projekt dessen Stack, Komponenten, Design-Tokens und Befehle.
6. Sonst erstelle in einem neuen Unterordner die kleinste passende Webanwendung. Benenne ihn kurz
   nach dem Unternehmen, ohne Standort- oder Tätigkeitszusätze: `kanzlei-fritz`, nicht
   `kanzlei-fritz-dortmund-redesign`. Überschreibe keinen fremden oder nicht leeren Ordner.
7. Ist die Website nicht erreichbar, versuche Screenshot, Seitentitel, Firmenname und öffentliche
   Treffer. Frage nur nach einem Link, wenn der Betrieb sonst nicht identifizierbar ist.

## 2. Bestand als geschützten Vertrag erfassen

In Modus A reichen Startseite, Kontakt- und Impressumsseite. In Modus B alle relevanten
Unterseiten. Erfasse:

- Logo, Farben, Schriften und wiedererkennbare Markenmerkmale. Sichere die Farbbelege einzeln: die
  Logodatei selbst, die Farbwerte aus Stylesheet und CSS-Variablen, und die Farben, die sich über
  mehrere Seiten hinweg auf Buttons, Links und Navigation wiederholen. Nicht die Farbe, die im
  Screenshot am meisten Fläche einnimmt, das ist meist ein Foto
- Angebot, Produkte, Kategorien, Zielgruppen und Einzugsgebiet
- Kontaktwege, Buchungswege, Formulare, Telefonnummern, E-Mail-Adressen und Öffnungszeiten
- Navigation, URLs, Anker, Downloads und wichtige externe Links
- Impressum, Datenschutz, Consent-Verhalten und weitere Pflichtseiten
- belegbare Vertrauenselemente wie Partner, Qualifikationen, reale Referenzen, verlinkte Bewertungen
- SEO-Titel, Beschreibungen, strukturierte Daten und indexierbare Inhalte
- vorhandene Accessibility-Verträge wie Skip-Link, Fokuszustände und Reduced Motion

Halte dabei fest, **was konkret Kunden kostet**, das ist später die erste Zeile der Mail: die
Telefonnummer erst im Fußbereich, kein `tel:`-Link, unlesbar auf dem Telefon, mehrere Sekunden
weißer Bildschirm, Preise oder Öffnungszeiten nicht auffindbar, Kontaktformular defekt.

Bewahre korrekte Fakten, funktionierende Kontaktwege, relevante URLs und rechtliche Seiten. Ändere
die visuelle Form frei, aber verliere keine geschäftskritischen Inhalte.

Mache in Modus A vor dem Umbau einen mobilen Screenshot der alten Startseite und nach dem Deploy
einen der neuen. Lege beide im Projektordner ab. Sie sind Material für Gespräch und Portfolio,
nicht für die Erstmail, Anhänge schaden dort der Zustellbarkeit.

## 3. Unternehmen und Markt recherchieren

Nutze aktuelle Webrecherche. Priorisiere die bestehende Website, offizielle Unternehmensprofile,
Hersteller- und Verbandsquellen und andere Primärquellen.

In Modus A genügen die ersten drei Fragen und ein kurzer Blick auf einen Wettbewerber. In Modus B
alle:

- Was verkauft der Betrieb wirklich, an wen und in welchem Gebiet?
- Welches Problem oder welcher Wunsch bringt Menschen auf die Website?
- Welche Auswahlkriterien, Einwände und Vertrauensfragen sind branchentypisch?
- Welche Suchintentionen und lokalen Begriffe passen zum Angebot?
- Wie präsentieren drei bis fünf Wettbewerber Angebot, Beweise und Handlungsaufforderungen?
- Welche Darstellung ist in der Branche selbstverständlich, und wo kann die neue Seite klarer sein?

Kopiere keine Texte oder Designs von Wettbewerbern. Nutze sie nur, um Erwartungen, Lücken und
Differenzierung zu erkennen. Übernimm aus Drittquellen keine ungeprüften Geschäftsfakten.

## 4. Conversion-Strategie festlegen

Bestimme genau ein primäres Conversion-Ziel und höchstens ein sekundäres:

- Anruf oder Angebotsanfrage für lokale Dienstleistungen
- Termin- oder Beratungsgespräch für beratungsintensive Angebote
- Reservierung für Gastronomie und Hospitality
- Produktkauf oder Kategoriesprung für Handel und E-Commerce
- Besuch, Probefahrt oder Verfügbarkeitsanfrage für lokale Produkte
- Bewerbung für Betriebe mit akutem Recruiting-Fokus

Formuliere vor dem Bau intern einen knappen Entscheidungsrahmen: Kernzielgruppe, stärkster
belegbarer Nutzen, primäre Handlung, wichtigste Einwände, notwendige Beweise, Abschnittsreihenfolge.

Lies [conversion-playbooks.md](references/conversion-playbooks.md) und verwende nur das zur
erkannten Branche passende Muster. Passe es an; behandle es nicht als starres Template.

## 5. Informationsarchitektur und Text entwickeln

- Führe mit einem konkreten Angebot, Ergebnis oder Unterschied statt mit austauschbaren Slogans.
- Schreibe in der Sprache der Kunden und im glaubwürdigen Ton des Betriebs.
- Ordne Inhalte entlang der Entscheidung: Verstehen, Relevanz erkennen, Vertrauen gewinnen, handeln.
- Zeige Produkte über Kategorien, Anwendungsfälle, Unterschiede und klare nächste Schritte.
- Zeige Dienstleistungen über Problem, Ablauf, Leistungsumfang, Eignung, Beweise und Anfrageweg.
- Mache Preis, Liefergebiet, Verfügbarkeit oder Ablauf transparent, wenn belegt.
- Nutze echte FAQ-Fragen zu Kaufhürden statt SEO-Fülltext.
- Verwende nur überprüfbare Aussagen. Markiere unvermeidbare Platzhalter sichtbar und sparsam.
- Halte primäre CTA-Texte spezifisch und konsistent.

### Marketing-Prinzip: warum es besser ist

Jede Aussage über Betrieb, Leistung oder Produkt muss den Grund mitliefern. Nicht „wir sind
exzellente Chirurgen", sondern was diese Exzellenz ausmacht und was der Kunde davon hat: Verfahren,
Fallzahl, Ausstattung, Nachsorge, Wartezeit, Ergebnisqualität, Ablauf. Ruhig, konkret, aus
Kundensicht, ohne Superlativ-Nebel.

- Formuliere nach dem Muster **Eigenschaft → warum das besser ist → was der Kunde dadurch gewinnt**.
  Die Eigenschaft allein ist nie die Botschaft.
- Belege das „warum" mit dem, was Recherche und Bestand hergeben. Erfinde keine Zahlen, Fallzahlen,
  Zertifikate oder Vergleiche, um eine Begründung zu erzwingen.
- Ist ein Vorteil nicht belegbar, schreibe die belegbare, kleinere Version. Streiche lieber eine
  Behauptung, als sie unbelegt zu stützen.
- Vergleiche gegen die Alternative des Kunden, nicht gegen benannte Wettbewerber: die übliche
  Vorgehensweise der Branche, der bisherige Umweg, das Nichthandeln.
- Ein Gedanke pro Abschnitt. Nutzenaussagen konkurrieren nicht, sie bauen aufeinander auf.
- Zeige das „warum" auch visuell, nicht nur im Text.
- Ton sachlich und selbstsicher. Kein Hype, keine Ausrufezeichen-Rhetorik, keine leeren
  Steigerungen wie „einzigartig", „revolutionär" oder „Premium" ohne Substanz.

Dieselbe Logik trägt später die Erstkontakt-Mail. Was sich hier nicht begründen lässt, taugt dort
auch nicht als Argument.

## 6. Gestaltung delegieren

Dieser Skill trifft keine gestalterischen Entscheidungen. Rufe `vbelt-design` auf; er legt Richtung,
Raum, Typografie, Farbe, Komposition, Navigation, Bildführung, Motion und Favicon fest, auch bei
deutschsprachigen Projekten. Baue hier keine eigenen Designregeln auf und wiederhole seine nicht.

Übergib ihm den hier erarbeiteten Rahmen und die Randbedingungen, die nur aus Bestand und Akquise
kommen:

- **Branche, Preispositionierung, Zielgruppe und das Conversion-Ziel aus Abschnitt 4.**
- **Markenbestand:** Logo, Kernfarben und Wiedererkennungsmerkmale bleiben erhalten. Welche Farben
  das sind und in welcher Rolle sie in der neuen Palette landen, entscheidet `vbelt-design`;
  geliefert werden die Belege, nicht schon die Auswahl. Typografie, Raster, Rhythmus, Bildführung und
  Interaktion dürfen frei modernisiert werden.
- **Fläche nach Modus, nicht Maßstab:** In Modus A eine Seite mit wenigen Abschnitten, in Modus B
  alle nötigen Seiten. Der gestalterische Maßstab ist in beiden Fällen derselbe und wird nicht
  gekürzt. Was tatsächlich am Umfang hängt, ist die Menge an Bildmaterial und echtes 3D, weil beides
  Material voraussetzt, das oft noch nicht existiert.
- **Vorhandenes Material:** Fotos der bestehenden Website gehören dem Betrieb und sind sein
  glaubwürdigster Bestand. Übernimm sie ausgewählt statt vollständig, und wo es viele echte Bilder
  gibt, bleibt eine spürbare Zahl davon erhalten. Das Heldenbild wird neu erzeugt, außer es existiert
  eines, das den Bildauftrag wirklich erfüllt. Welche Bilder bleiben und wie das Erzeugte dagegen
  gebrieft wird, entscheidet `vbelt-design`. Das Logo nur unverändert und nur zur Identifikation.

Fehlende Visuals konzipiert und erzeugt `vbelt-imagegen`, mit den Bildaufträgen, die
`vbelt-design` festlegt. Inspiziere die Ergebnisse, iteriere bei Artefakten und optimiere die Dateien
fürs Web.

## 7. Implementieren

- Verwende den vorhandenen Stack und die einfachste robuste Lösung. In Modus A: `pnpm`, damit
  `vbelt-deploy` direkt anschließen kann.
- Implementiere reale Navigation, Links, Telefonnummern, E-Mail- und Buchungswege.
- Erhalte bestehende funktionierende Integrationen. Täusche bei Formularen, Checkout oder
  Terminbuchung keine erfolgreiche Übermittlung vor.
- Nutze semantisches HTML, sinnvolle Überschriften, Labels, Alt-Texte, Tastaturbedienung und
  sichtbare Fokuszustände.
- Optimiere Bilder, Fonts und Above-the-fold-Inhalte. Vermeide unnötiges JavaScript und
  renderblockierende Ressourcen.
- Pflege Seitentitel, Meta Description, Canonical, Social Preview und strukturierte Daten mit
  ausschließlich belegbaren Fakten.
- Füge keine Analytics-, Tracking- oder Marketing-Skripte ohne vorhandene Konfiguration oder
  ausdrücklichen Auftrag hinzu.
- Erhalte Impressum, Datenschutz und Consent-Verhalten; erfinde keine Rechtsberatung.

### Pflichten der Akquise-Demo (Modus A)

Die Demo trägt fremden Namen und fremdes Logo auf eigener Domain. Ohne diese Punkte wird nicht
deployt und nicht kontaktiert.

**Dieser Abschnitt ist die einzige verbindliche Fassung dieser Pflichten.** `outreach.md` und die
Gates in `vbelt-akquise` verweisen hierher und wiederholen die Liste nicht, damit die Fassungen nicht
auseinanderlaufen. Ändert sich etwas, ändert es sich hier.

Maschinell geprüft, nach dem Deploy durch `verify-demo.sh` (Abschnitt 9):

- `<meta name="robots" content="noindex, nofollow">`, die Demo darf nicht indexiert werden und der
  echten Seite keine Suchkonkurrenz machen.
- Ruhiger Demo-Hinweis im Footer: „Unverbindlicher Entwurf von <identity.name>. Dies ist nicht
  die offizielle Website von <Firma>." mit Kontaktmöglichkeit zur Rücknahme. `<identity.name>`
  ist der Absendername aus `~/.config/vbelt/config.json`, nie ein Platzhalter im Live-HTML. Das Skript sucht genau
  nach „Unverbindlicher Entwurf" oder „nicht die offizielle Website", eine frei umformulierte
  Fassung fällt durch, auch wenn sie inhaltlich stimmt.
- Viewport-Meta gesetzt.
- Öffentlich erreichbar über HTTPS mit gültigem Zertifikat, echter Inhalt statt Hoster-Fehlerseite.
- Telefonnummer als `tel:` verlinkt. Das Skript meldet das Fehlen nur als Hinweis; bei einem lokalen
  Betrieb ist es trotzdem ein Baufehler.

Nur beim Bauen sicherzustellen, weil kein Skript es sehen kann:

- Eigenes Impressum des Absenders. Übernimm niemals das fremde Impressum und stelle keine fremden
  Rechtstexte als eigene dar.
- Kontaktwege zeigen auf die echten Daten des Betriebs (`tel:`, echte E-Mail). Baue kein Formular,
  das echte Interessentendaten beim Absender sammelt.
- Keine erfundenen Preise, Öffnungszeiten, Bewertungen, Zertifikate oder Mitarbeiter.

### Skeleton Screens statt Spinner

Jeder Bereich, der nicht sofort mit Inhalt da ist, bekommt einen Skeleton, der die spätere Struktur
vorwegnimmt. Ein zentrierter Spinner ist kein Ladezustand, sondern ein Platzhalter für fehlende
Arbeit. In Modus A betrifft das meist nur Bilder und Medien, in Modus B alles Nachgeladene.

- Baue Skeletons formgleich zum Endzustand: gleiche Blockhöhen, Spaltenzahl, Bildseitenverhältnisse
  und Zeilenanzahl. Der Wechsel auf den echten Inhalt darf nichts verschieben.
- Setze sie überall ein, wo Inhalt nicht sofort verfügbar ist: Listen, Produktraster, Karten, Bild-
  und Map-Einbindungen, Verfügbarkeits- und Buchungsdaten, nachgeladene Abschnitte.
- Vermeide Flackern: unter etwa 200 ms Ladezeit lieber nichts zeigen, danach den Skeleton für eine
  sichtbare Mindestdauer stehen lassen.
- Halte den Shimmer dezent und respektiere `prefers-reduced-motion`; dort genügt eine ruhige Fläche.
- Kennzeichne ladende Regionen zugänglich, etwa über `aria-busy` und eine verständliche
  Statusmeldung. Halte Fokus und Scrollposition beim Austausch stabil.
- Für schwere Medien und 3D gilt dasselbe: sofort ein optimiertes Poster oder eine Platzhalterfläche
  in korrekter Größe, nie ein springender Leerraum.
- Führe Fehlerfälle aus dem Skeleton in eine verständliche Meldung mit Retry, nicht in endloses
  Laden.

### Optimistic UI konsequent einsetzen

Gilt, sobald es echte Interaktion mit Serverzustand gibt. In einer statischen Demo ohne Backend
entfällt es, simuliere dort keine Persistenz.

- Gib bei jeder relevanten Interaktion sofort sichtbares Feedback. Aktualisiere Warenkorb,
  Favoriten, Varianten, Filter, gespeicherte Auswahl oder Buchungsschritte optimistisch, ohne auf
  die Netzwerkrunde zu warten.
- Behandle Server und bestehende Integration als verbindliche Quelle. Kennzeichne ausstehende
  Aktionen, verhindere Doppelübermittlungen und gleiche den lokalen Zustand nach der Antwort ab.
- Rolle fehlgeschlagene Änderungen verständlich zurück oder biete einen klaren Retry. Erhalte
  Formulardaten und Auswahl, statt Nutzer nach einem Fehler von vorn beginnen zu lassen.
- Melde Bestellung, Zahlung, Buchung oder Formularversand erst nach echter Bestätigung als
  erfolgreich. Zeige davor einen ehrlichen Pending-Zustand, keinen erfundenen Abschluss.
- Kündige Zustandsänderungen zugänglich an, etwa über Status-Texte und `aria-live`. Vermeide
  Layoutsprünge zwischen Idle, Pending, Erfolg und Fehler.

## 8. Prüfen

Führe die im Repo vorgesehenen Lint-, Typ-, Test-, Format- und Build-Befehle aus. Prüfe danach im
Browser das, was tatsächlich Geschäft kostet:

- den primären Conversion-Weg vollständig auf Mobile (390 × 844) und Desktop (1440 × 900), von oben
  bis zum ehrlichen Endzustand, nicht nur den Hero
- horizontales Overflow, abgeschnittene Inhalte, kollidierende Sticky-Elemente, lange reale Begriffe
- Formulare mit offener Bildschirmtastatur: sichtbare Felder, erreichbarer Absende-Button,
  verständliche Fehler
- Tastaturreihenfolge, Fokus, Kontrast, Alt-Texte und Reduced Motion
- Skeleton- und Optimistic-UI-Verhalten unter Latenz, Fehlerantwort und Doppelklick: kein
  Layoutsprung, korrektes Rollback, kein erfundener Erfolg
- 3D und Motion mit Touch, Reduced Motion und deaktiviertem WebGL; Inhalt und CTA müssen vor dem
  3D-Asset nutzbar sein
- generierte Bilder auf Artefakte, falsche Produktdetails und irreführende Realitätstreue
- kein Framework-Icon mehr im Browsertab; ein eigenes Favicon wird nicht gebaut
- Console-Fehler, fehlende Assets und mobiles LCP; strebe LCP unter 2,5 s und CLS nahe 0 an

In Modus A zusätzlich die Pflichten der Akquise-Demo aus Abschnitt 7, vollständig und einzeln,
auch die vier, die kein Skript sehen kann.

Erstelle Screenshots der entscheidenden Zustände und verbessere iterativ. Ein erfolgreicher Build
allein schließt die Aufgabe nicht ab.

## 9. Veröffentlichen

In Modus A immer, in Modus B auf Ansage. Nutze den Skill `vbelt-deploy`; er übernimmt Repo,
Push, Vercel-Projekt mit Git-Auto-Deploy, optionale Domain und Verifikation der Live-URL.

Wähle einen Slug, der den Betrieb erkennbar macht und keine fremde Marke als eigene Domain
inszeniert: bevorzugt `firmenname`, bei Kollision `firmenname-ort`.

Prüfe die öffentliche URL nach dem Deploy, bevor sie in einer Mail steht. Eine Demo-URL, die nicht
lädt, ist schlimmer als keine Mail:

```bash
~/.claude/skills/vbelt-akquise/scripts/verify-demo.sh <LIVE_URL>
```

Exit 0 heißt: die URL darf in eine Mail. Das Skript deckt die maschinell prüfbaren Pflichten aus
Abschnitt 7 ab; die übrigen bleiben deine Sache.

Mache jetzt den mobilen Screenshot der neuen Seite und lege ihn neben den der alten.

**Stammt der Lead aus der Lead-API** (Abschnitt 1, weil im Auftrag keine Website mitgeliefert wurde),
melde jetzt mit `POST /api/build/{id}/built` (siehe `vbelt-lead`) die Live-URL und eine kurze
Notiz zum Gebauten. Ohne diese Meldung bleibt der Lead bis zum sechs-stündigen Verfall
reserviert. Kannst
du den Lauf vor dieser Meldung nicht erfolgreich abschließen, gib die Reservierung sofort mit
`POST /api/build/{id}/release` zurück. Melde niemals `built`, bevor Deploy, öffentliche Prüfung und
Demo-Gate erfolgreich waren.

## 10. Erstkontakt vorbereiten und senden

Nur Modus A. Lies [outreach.md](references/outreach.md) und folge ihm genau, dort stehen
Demo-Absicherung, Adressermittlung, Ton, Betreff, Mailgerüst, Nachfassen und Logführung.

Kurzform des Ablaufs:

1. Prüfen, ob der Betrieb schon im Log steht, ausgeführt, nicht erinnert:
   `grep -in -e "<domain-ohne-www>" -e "<firmenname>" ~/vbelt-log.md || echo "nicht im Log"`.
   Jede andere Ausgabe heißt: kein zweiter Erstkontakt.
2. Empfängeradresse aus dem Impressum bestimmen. Niemals eine Adresse raten oder aus einem
   Namensschema ableiten. Ist keine auffindbar, melde das und schlage Anruf oder Kontaktformular vor.
3. Mail nach dem Gerüst in `outreach.md` schreiben. Die erste Zeile ist eine konkrete, überprüfbare
   Beobachtung zu **dieser** Seite und darf in keiner zweiten Mail so vorkommen.
4. Vollständige Mail im Chat zeigen: Empfänger, Quelle der Adresse, Betreff, Text, Signatur,
   Demo-URL.
5. Auf ausdrückliche Zustimmung warten. „Senden" heißt senden, alles andere heißt überarbeiten.
   Sende niemals unaufgefordert und niemals an mehrere Empfänger in einem Durchlauf.
6. Text in eine Datei schreiben und senden:

```bash
python3 ~/.claude/skills/vbelt/scripts/send-mail.py \
  --to "<adresse>" \
  --subject "<betreff>" \
  --body-file "<pfad zur textdatei>"
```

   Das Skript nutzt Absender und SMTP-Zugang aus `~/.config/vbelt/config.json` (Abschnitte
   `identity` und `mail`), das Passwort aus Umgebungsvariable, Passwortdatei oder macOS-Keychain,
   sendet an genau einen Betrieb und gibt die Message-ID aus. Ist nichts
   eingerichtet, erklärt es die Einrichtung. Mit `--check` lässt sich der Login prüfen, mit
   `--dry-run` die fertige Mail ansehen.

   **Jede Mail geht zusätzlich als Blindkopie an die Archivadressen.** Sie stehen als Liste
   `mail.bcc` in `~/.config/vbelt/config.json` und werden automatisch
   gesetzt, ohne Zutun und ohne zusätzliches Argument. Das ist nicht optional, sondern das Archiv: SMTP-Versand legt nichts im
   „Gesendet"-Ordner des Postfachs ab, ohne die Kopie gäbe es keinen Beleg über das Verschickte.
   Der Empfänger sieht die Blindkopie nicht. Unterdrücke sie nur bei technischen Tests mit
   `--no-bcc`, nie bei einer echten Akquise-Mail.

6. Message-ID notieren. Das Nachfassen nach fünf bis sieben Tagen läuft mit `--in-reply-to` im
   selben Verlauf, genau einmal.
7. Log in `~/vbelt-log.md` fortschreiben (Format in `outreach.md`).

## 11. ORIGIN.md schreiben

Nur Modus B. Lege im Projektordner (neben der Anwendung, nicht im Build-Output) einen Ordner `docs/`
an, falls er noch nicht existiert, und darin `ORIGIN.md`. Sie
ist technische Herkunftsdokumentation und Verkaufsargumentation für das Gespräch. Schreibe sie in
der Sprache der Website und wende das Marketing-Prinzip aus Abschnitt 5 an: jede Verbesserung wird
begründet, nicht behauptet.

1. **Original**, vollständige URL, Firmenname, Standort, Abrufdatum, ausgewertete Unterseiten,
   erkennbarer Ausgangs-Stack.
2. **Ausgangszustand**, was die alte Seite geschäftlich geleistet hat und wo sie Kunden verloren
   hat: unklare Positionierung, versteckte Kontaktwege, fehlende Beweise, Mobile-Verhalten,
   Ladezeit, Struktur, Auffindbarkeit. Sachlich, ohne Verhöhnung der bisherigen Arbeit.
3. **Vergleich alt gegen neu**, Tabelle mit *Bereich · vorher · jetzt · warum das besser ist*. Die
   letzte Spalte ist die wichtigste; ohne Begründung verfehlt die Zeile ihren Zweck.
4. **Bewahrter Bestand**, welche Fakten, Kontaktwege, URLs, Rechtsseiten und Markenmerkmale
   unverändert übernommen wurden. Das nimmt die Angst vor dem Relaunch.
5. **Verkaufsargumentation**, der Kern, gegliedert nach Wirkung:
   - **Mehr Anfragen / Umsatz**: gewähltes Conversion-Ziel, Weg dorthin, entfernte Reibung.
   - **Mehr und besserer Traffic**: Struktur, Suchintentionen, lokale Sichtbarkeit, Titel und
     Beschreibungen, strukturierte Daten, Seitengeschwindigkeit.
   - **Bessere Interaktion**: Verständlichkeit, Produkt- und Leistungsdarstellung, Bild- und
     Motion-Einsatz, wahrgenommene Geschwindigkeit durch Skeleton Screens, sofortiges Feedback
     durch Optimistic UI, weniger Abbrüche.
   - **Leichterer Zugang**: Mobile, Barrierefreiheit, Tastaturbedienung, Kontakt in einem Schritt,
     Verhalten bei langsamer Verbindung.
   - **Glaubwürdigkeit**: welche Beweise sichtbar wurden und warum sie Einwände auflösen.

   Formuliere jeden Punkt als *Maßnahme → Wirkungsmechanismus → erwarteter Geschäftseffekt*.
   Beschreibe den Mechanismus nachvollziehbar, aber erfinde keine Prozentzahlen, Umsatzprognosen,
   Rankings oder Kennzahlen. Nennst du eine Größenordnung, kennzeichne sie als Erwartung und nenne
   die Grundlage.
6. **Offene Punkte**, welche Fakten, Assets, Zugänge oder Integrationen der Betrieb noch bestätigen
   oder liefern muss.
7. **Quellen**, die genutzten Links.

Die Datei muss ohne mündliche Erklärung funktionieren. Aktualisiere sie bei späteren Änderungen mit.

## 12. Abschluss liefern

Fasse knapp zusammen:

- welcher Modus lief und was gebaut wurde
- welches primäre Conversion-Ziel gewählt wurde und warum
- welche Recherche Struktur oder Darstellung beeinflusst hat
- welche Prüfungen bestanden wurden
- in Modus A: Demo-URL, gefundene Kontaktadresse samt Quelle, Status der Mail und der nächste
  Schritt mit Datum
- in Modus B: die drei stärksten Verkaufsargumente aus `docs/ORIGIN.md`, jeweils mit Begründung
- welche Fakten oder Integrationen noch bestätigt werden müssen
- eine passende Conventional-Commit-Empfehlung

Verlinke die wichtigsten geänderten Dateien und nenne Recherchequellen dort, wo sie Entscheidungen
oder aktuelle Tatsachen stützen.
