# Target design language

What a finding gets fixed towards. Derived from the "Dashboard Flaws" Figma reference (employee
table, proposal activity panel, incident tracking, onboarding checklist, sharing dialog) and
translated into the project's tokens. The reference sets the character, not the pixels: copy
its decisions, not its screens.

The character in one sentence: **a quiet, neutral work surface where only data, state and the
one next action carry weight.**

## Principles taken from the reference

1. **Ink and paper.** Near white surfaces, near black text and primary buttons, hairline
   borders. Colour appears only where it means something (status, one chart series, links).
2. **The table is the product.** Most screens are a card holding a toolbar and a table. The
   table is calm: hairline row separators, generous but fixed row height, no zebra stripes,
   no vertical lines.
3. **Headers explain the column type.** Sentence case header text with a small type icon
   (hash, calendar, envelope, person, tag), not spaced capitals.
4. **Tools are icons, the action is a word.** Sort, filter, view, search and settings are a
   row of icon buttons; the single primary action is a labelled dark button with a plus.
5. **Details slide in, the list stays.** Records open in a right side panel with a state
   banner, a timeline and key value blocks.
6. **State is written, not painted.** Pills carry icon and word; categories are neutral chips
   with a dot; inactive rows are faded as a whole.
7. **Loading looks like the page.** Skeleton blocks in the shape of the real layout.

## Translation into TalentBridge tokens

| Element | Reference | TalentBridge target |
|---|---|---|
| App background | white | `--neutral-50` |
| Card | white, hairline border, radius about 10 px | `--card`, 1 px `--border`, `--radius` (10 px), no shadow |
| Text | near black, grey secondary | `--neutral-900`, secondary `--neutral-600` |
| Primary button | near black, white text, plus icon | `--neutral-900` solid, white text, height 36 px, radius `--radius-md`; hover `--neutral-700`. No gradient. |
| Secondary button | white, hairline border | `--card`, 1 px `--input`, `--neutral-900` text |
| Icon button | 32 to 36 px, no border, grey icon | 36 px, `--neutral-600` icon, hover `--neutral-100` background, `aria-label` and tooltip |
| Accent | blue for links and info | `--brand-600` for links, active navigation marker, progress, focus ring (`--ring`) |
| Status pill | tinted, icon plus word | `--status-*` text, `--status-*-bg` background, 14 px icon |
| Category chip | white chip, coloured dot | `--card`, 1 px `--border`, 8 px dot |
| Table header | 13 px medium, grey, sentence case, type icon | 13 px `font-medium` `--neutral-600`, sentence case, 14 px Lucide icon. Not mono, not uppercase. |
| Table row | about 40 px, hairline separator | 40 px desktop, 1 px `--border` separator, hover `--neutral-50` |
| IDs, codes, dates in tables | regular | `--font-mono` only for IDs and codes; dates in sans with `tabular-nums` |
| Chart | one saturated colour, faint grid | one series in `--brand-500`, grid `--neutral-100`, labels 11 px `--neutral-500` |
| Side panel | 400 to 480 px, right, rounded | 440 px, `--card`, left hairline, full height below the top bar |
| Info banner | tinted blue, icon | `--status-info-bg`, `--status-info` text, info icon |

Mono uppercase eyebrows ("NEUE BEWERBUNGEN", "DÜSSELDORF, VOLLZEIT") are the current
TalentBridge signature. In the target they survive only for the area label in the sidebar
("BACKOFFICE") and for codes; everywhere else labels are sentence case sans.

## Type scale for logged-in pages

| Role | Size and weight |
|---|---|
| Page title | 28 px, semibold, tracking tight |
| Card or section title | 16 px, semibold |
| Body, table cells | 14 px, regular |
| Labels, table headers | 13 px, medium |
| Meta, helper text | 12 px, regular, `--neutral-600` |
| Metric number | 28 to 32 px, semibold, `tabular-nums` |

Spacing scale: 4, 8, 12, 16, 24, 32. Page padding 32 px desktop, 16 px mobile.

## Desktop page in the target language

```
Bewerbungen                                               [+ Bewerbung erfassen]
Alle Standorte, letzte 30 Tage
+-------------------------------------------------------------------------------+
| (Eingegangen 1) (Termin vereinbart 0) (Zugesagt 0) (Alle 3)   [search][filter][sort] |
|-------------------------------------------------------------------------------|
| [ ] # Eingang   (o) Name          [] Stelle            * Ort     Status        ... |
| [ ] 14.09.2026  Ayse Demir         Auf- und Abbauhelfer  München  (i) Eingegangen ... |
| [ ] 30.09.2026  Jonas Weber        Promotionkraft        Köln     (-) Zurückgezogen   |  <- faded row
+-------------------------------------------------------------------------------+
```

## Mobile translation

The reference is desktop only. On phones the same character holds with these changes:

- **Top bar**: area logo left, page title is in the content, menu icon right. Drawer
  navigation shows counts like the desktop sidebar; log out is an icon in the drawer footer.
- **Tables become row lists** below 768 px. Each row: line 1 the name or title plus the
  status pill, line 2 the two attributes the person decides on, muted. Tap opens the record as
  a full screen sheet with a back button. No table is ever clipped or scrolled sideways.
- **Toolbar**: filter chips in one horizontally scrollable row with counts; search collapses
  into an icon that expands over the chips.
- **Metric tiles** do not stack full width. Either their counts live on the chips, or they
  become one compact row of two or three numbers.
- **Primary action** stays on the title line as a compact button; no floating action button.
- **Row actions** move into the sheet; a list row has no buttons.

## Typical replacements

| Current pattern | Target |
|---|---|
| Metric tiles above a table | Counts on the filter chips |
| Mono uppercase table headers | Sentence case headers with type icon |
| Stacked buttons per row | One "more" icon button, actions in the panel |
| Card per record with buttons (Kündigungen) | Table or row list with status pill, actions in the panel |
| Explanation repeated in every item | Status pill, explanation once in the panel or tooltip |
| Dashed empty box | Empty state inside the standard card |
| Green gradient or black buttons mixed | Ink primary everywhere |
| Multi line subtext | One line of scope, details in "Mehr erfahren" or the action dialog |
| Text link "Abmelden" | Log out icon button |
