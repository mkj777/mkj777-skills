# A11y- und Inhaltsprüfung, der Teil, den Lighthouse nicht kann

Lighthouse prüft Syntax: fehlende Attribute, Kontrastwerte, ARIA-Regeln. Was hier steht, prüft
Bedeutung: ob Alt-Texte stimmen, ob Überschriften den Inhalt tragen, ob die Reihenfolge Sinn
ergibt. Diese Prüfung braucht den Seiteninhalt, deshalb läuft sie über den A11y-Baum
(`take_snapshot`), einen Screenshot (`take_screenshot`) und gezielte `evaluate_script`-Aufrufe.

Jedes Finding nennt das Element aus dem Snapshot (Rolle, Name, uid) oder einen CSS-Selektor aus
`evaluate_script`. Kein Finding ohne Element. Keine Zahl, die nicht aus einem Aufruf stammt.

## 1. Überschriften gegen den tatsächlichen Inhalt

Snapshot lesen, alle `heading`-Einträge mit Level in Reihenfolge herausschreiben. Dann:

- Genau ein H1, und es benennt, worum es auf dieser Seite geht (nicht den Firmennamen allein,
  nicht "Willkommen").
- Keine übersprungene Stufe (H2 nach H4 ohne H3 dazwischen ist ein Finding).
- Jede Überschrift beschreibt den Abschnitt, der ihr folgt. Eine Überschrift, die nur groß
  gesetzt ist, weil das gut aussieht, und keinen Abschnitt einleitet, ist ein Finding.
- Text, der wie eine Überschrift aussieht (Screenshot), aber im Snapshot kein `heading` ist:
  Finding "visuelle Überschrift ohne Semantik".

## 2. Alt-Texte inhaltlich

`evaluate_script`: alle `<img>` mit `src`, `alt`, Größe im Viewport, ob `alt` fehlt oder leer ist.
Dann pro Bild gegen den Screenshot beurteilen:

- Informatives Bild: `alt` sagt, was zu sehen ist, im Kontext der Seite ("Team von X vor der
  Werkstatt in Y", nicht "Bild", "Foto", "IMG_2041", nicht die Keyword-Liste).
- Dekoratives Bild (Hintergrund, Trenner, reines Ornament): `alt=""` ist richtig, ein
  beschreibender Text hier ist ein Finding, weil er den Screenreader-Fluss stört.
- Bild mit Text darin (Logo, Banner, Grafik mit Zahlen): `alt` enthält diesen Text.
- Verlinktes Bild: `alt` beschreibt das Ziel ("Zur Startseite"), nicht das Bild.
- `<svg>` als Icon in einem Button ohne Namen: siehe Abschnitt 3.

## 3. Link- und Button-Texte aus dem Kontext

Snapshot: alle `link`- und `button`-Einträge mit ihrem accessible name.

- Mehrfach gleicher Name mit unterschiedlichem Ziel ("Mehr erfahren" fünfmal): Finding, mit
  Vorschlag pro Vorkommen ("Mehr zu Leistung X").
- Leerer Name (Icon-Button, Bild-Link ohne alt): Finding, `aria-label` oder sichtbarer Text.
- Name beschreibt die Aktion, nicht den Mechanismus ("Termin anfragen" statt "Hier klicken").
- Links, die neue Fenster öffnen oder Dateien laden, sagen das im Namen oder daneben.

## 4. Fokusreihenfolge und Tastatur

`evaluate_script` mit einem Skript, das alle fokussierbaren Elemente in DOM-Reihenfolge sammelt
(`a[href], button, input, select, textarea, [tabindex]:not([tabindex="-1"])`), mit `tabindex`,
Tag, accessible name und `getBoundingClientRect()`. Dann:

- Reihenfolge entspricht der visuellen Leserichtung (Screenshot). Ein Element, das visuell oben
  rechts liegt, aber als letztes fokussiert wird, ist ein Finding.
- Positive `tabindex`-Werte sind fast immer ein Finding.
- Skip-Link als erstes fokussierbares Element ("Zum Inhalt springen"), der auf `<main>` zielt.
- Sichtbarer Fokus: `evaluate_script` fokussiert nacheinander drei typische Elemente (Nav-Link,
  primärer Button, Formularfeld) und liest `getComputedStyle(el).outlineStyle` und `boxShadow`.
  `outline: none` ohne Ersatz ist ein Finding.
- Menü und Modal: Escape schließt, Fokus kehrt zum Auslöser zurück, kein Fokus-Trap außerhalb
  eines geöffneten Modals. Prüfen mit `press_key` und erneutem Snapshot.

## 5. Formulare

Snapshot und `evaluate_script` über alle `input`, `select`, `textarea`:

- Jedes Feld hat ein programmatisch verbundenes Label (`<label for>`, `aria-labelledby` oder
  `aria-label`). Placeholder ist kein Label.
- Pflichtfelder sind als solche markiert, sichtbar und per `required` oder `aria-required`.
- `autocomplete` auf Name, E-Mail, Telefon, Adresse gesetzt.
- Fehlermeldungen: Formular mit leeren Pflichtfeldern absenden (`click` auf Submit), dann
  Snapshot. Die Meldung steht beim Feld, ist per `aria-describedby` verbunden, sagt konkret,
  was fehlt und was zu tun ist ("Bitte eine E-Mail-Adresse mit @ eingeben", nicht "Ungültige
  Eingabe"). Eine Meldung, die nur rot färbt, ist ein Finding.
- Erfolgs- und Fehlerzustand nach dem Absenden werden angesagt (`role="status"` oder
  `aria-live`).

## 6. Sprache und Copy

- `<html lang>` passt zur Sprache des Inhalts. Abschnitte in anderer Sprache tragen ein eigenes
  `lang`.
- Leerzustände und Fehlerseiten sagen, was passiert ist und was der Nutzer jetzt tun kann.
- Kein Text, der nur als Bild vorliegt, ohne Entsprechung im DOM.
- Abkürzungen beim ersten Vorkommen ausgeschrieben oder per `<abbr>` erklärt, wenn sie nicht
  allgemein bekannt sind.

## 7. Landmarks und Struktur

Snapshot: `banner`, `navigation`, `main`, `contentinfo`, `complementary`, `search`.

- Genau ein `main`. Fehlt es, Finding.
- Mehrere `navigation`-Landmarks tragen unterscheidbare Namen (`aria-label="Hauptnavigation"`,
  `"Footer"`).
- Keine redundanten Rollen (`<nav role="navigation">`, `<button role="button">`).
- Listen sind Listen (`ul`/`ol`), nicht `div`-Stapel mit Bullet-Zeichen.

## 8. Was hier nicht geprüft wird

- Farbkontrast: kommt aus Lighthouse (`color-contrast`). Nicht schätzen, nicht "wirkt zu hell".
- Zoom auf 200 Prozent, Reflow, Bewegungsreduktion: nur, wenn der Nutzer es verlangt, dann mit
  `emulate` (Viewport) und `resize_page`, und mit Screenshot als Beleg.
- Screenreader-Verhalten im echten Screenreader: kann dieses Setup nicht. Findings aus dem
  A11y-Baum sind Hinweise auf wahrscheinliche Probleme, nicht deren Bestätigung. Das steht so im
  Report.

## Format eines Findings

```
- [Abschnitt 2] img `header .hero img` (uid e42): alt="hero.jpg" ist ein Dateiname.
  Vorschlag: alt="Blick in die Backstube der Bäckerei Müller, Meister am Ofen".
  Schwere: hoch (LCP-Bild, erstes Bild der Seite).
```

Schwere: hoch (blockiert Nutzung oder verfälscht Inhalt), mittel (erschwert Nutzung), niedrig
(Kosmetik, Konsistenz).
