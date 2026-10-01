# Visual system

Measured values and ratios behind the hard rules. Sources: a light data app (table, side panel,
chart, checklist, share dialog), a dark SaaS dashboard (metric cards, list card, settings with
usage), a light and dark footer pair, and audits of production dashboards. Absolute pixels
differ between products; the **ratios** are what transfers. Map them onto the project tokens
through the project profile.

## 1. Spacing

### Scale

4, 8, 12, 16, 24, 32, 40, 48, 64. Everything on the 4 px grid, most on the 8 px grid.

| Relationship | Value | Reference evidence |
|---|---|---|
| Related (label to its field, helper under field, icon to label) | 4 to 8 | helper 10 px under field in the improved form |
| Items (field to field, sibling cards, chip to chip) | 12 to 16 | 16 between fields; 12 to 16 between cards |
| Groups (section to section) | 32 to 56, 2.5 to 3.5x the item gap | 40 subtitle to tabs; 48 and 64 in settings |
| Header to first card | 24 to 40, one value per product | 20 to 40 in the references |
| Card padding | 16 (dense) or 24 (forms, settings) | one value per product |
| Page gutter, desktop | 32 to 64, always larger than card padding | 60 light reference, 40 dark reference |
| Page gutter, mobile | 16 | |
| Floating margin (side panel, popover) | 8 | |

Checks:

- **Proximity:** a label's gap to its own field is at most half its gap to the previous field.
  The worse form in the comparison had 11 px to its own field and 14 px to the previous one,
  so labels floated between fields.
- **One gap per relationship:** sibling cards use the same gap horizontally and vertically.
  The dark reference used 12 sideways and 36 downwards and looked uneven.
- **Symmetric padding:** top and bottom card padding match; nothing crowds the bottom edge.
- **Three tiers only** in one card. The worse form used eight distinct vertical gaps, the
  better one three (10, 16, about 50).

### Heights

| Element | Height | Ratio |
|---|---|---|
| Dense table row | 36 to 44 | 2.5 to 3.3x body size |
| Table header row | same as body row | |
| Two line list row | 56 to 96 | up to 5.5x body |
| Settings key and value row | 44 to 48 | |
| Compact control (chip, pill, segmented tab) | 22 to 28 | |
| Default control (button, input, select, search) | 32 to 40, one value per product | |
| Touch target (mobile) | at least 44 | |
| Top bar | 44 to 48 | |
| Icon button pitch in a toolbar | 32 | |

Audit evidence: production tables at 56 to 98 px per row showed 3 to 7 rows per screen
instead of 15 or more; one toolbar mixed five control heights (46, 40, 30, 26, 24).

### Widths

| Element | Width |
|---|---|
| Sidebar | 240 to 248, the same in every area of the product |
| Side panel | about 25 percent of the viewport (about 360 to 440 at 1440) |
| Readable form or text column | 640 to 720 max |
| Lists and tables | full content width |

## 2. Type

### Levels

| Level | Size relative to body | Weight | Colour level |
|---|---|---|---|
| Page title | about 1.85x (body 14: 24 to 28) | semibold or bold, tight tracking | primary |
| Metric number | 2 to 2.4x its label | semibold or bold, tabular | primary |
| Section or card title | 1.15 to 1.3x | semibold | primary |
| Body, table cell | 1x (13 to 14 desktop, 14 to 16 mobile) | regular | primary |
| Column header, label, tab | 0.93 to 1x | medium | secondary |
| Meta, helper, timestamps | 0.85 to 0.92x (min 12) | regular | muted |
| Chart axis | about 0.65 to 0.8x (min 11) | regular | muted |

At most six sizes per screen; references used five to six. Active and inactive tabs, headers
and cells at the same size differ by weight and colour only.

### Case, tracking, mono

- Sentence case for descriptions, section labels, buttons, headers. Title case is acceptable
  for navigation and page titles if used consistently.
- Spaced uppercase (tracking 0.08 to 0.1 em, about 11 px, semibold) appears **only** on
  navigation group labels. Audit evidence: products that use spaced uppercase mono in nine
  label roles (headers, tile labels, eyebrows, badges, tags) read like a terminal and remove
  word shapes the eye scans by.
- Mono only for copyable machine identifiers (short links, keys, code). URLs, dates and
  numbers stay in the sans font with `font-variant-numeric: tabular-nums`.
- Numbers right aligned in tables; thousands separators in the locale of the product.

## 3. Colour roles

Define roles, then assign project tokens to them in the project profile.

| Role | Light theme | Dark theme |
|---|---|---|
| Page | near white or white | darkest neutral |
| Sidebar | page colour or one step off | one step lighter than page |
| Card, popover | white, separated by hairline border | one step lighter than sidebar, with border |
| Filled control (tab track, chip fill, row hover) | very light grey | one further step |
| Hairline border | about 1.15 to 1.25:1 against its surface | about 1.15 to 1.25:1 above its fill |
| Text primary | near black | near white |
| Text secondary | mid grey, about 7:1 | light cool grey, about 7:1 |
| Text muted | grey at least 4.5:1 on the card | grey at least 4.5:1 on the card |
| Primary button | near black fill, white text (about 16:1) | raised neutral fill (about 1.4:1 against page), near white text, leading icon |
| Accent | one hue: selection, progress, focus ring, inline links, active nav marker | brighter variant of the same hue |
| Semantic | ok, info, warn, danger: text on a pale tint of the same hue | same, text brighter, tint darker |
| Chart | one hue per series; first series uses the accent or a dedicated chart hue | same |
| Categorical | small dots only, 4 to 6 hues, never filled chips in many colours | same |

Light theme layers by **borders on white surfaces**; fills are reserved for tracks, inputs,
chips, disabled rows and dialog footer bands. Dark theme layers by **stepping luminance up**
(page 1.00, sidebar about 1.04, card about 1.09, control about 1.44 relative contrast) and gives
every raised surface a 1 px border; neutrals may carry a faint tint of the brand hue.

Audit evidence against these roles:

- One brand colour used on logo, links, eyebrows, captions, pills, buttons, progress and
  decoration at once: nothing signals anything any more.
- Two primary button styles (black and a brand gradient) in one product, the same action in
  both styles on different pages.
- White text on a light to mid brand gradient measured 1.9 to 3.7:1.

## 4. Contrast

| Pair | Minimum |
|---|---|
| Any text, hard minimum | 4.5:1 on the surface it sits on |
| Primary text, target | about 12:1 or more (references 15 to 21) |
| Secondary text, target | about 7:1 (references 5 to 7.5) |
| Muted text, target | 4.5 to 5.5:1, still visibly lighter than secondary |
| Status pill text on its tint | 4.5:1 at the size used (small mono caps need more) |
| Input border, meaningful icon, focus ring | 3:1 (inputs 3 to 4.5:1) |
| Layout hairline | about 1.2:1 is fine, it is decorative |
| Disabled | may be lower, only for truly disabled content |
| Button label on fill | 4.5:1 on every gradient stop |

Measure with `scripts/contrast.py`, including alpha tokens composited on their surface.
Common failures in audits: muted grey tokens at 2.5 to 3.1:1, warn badge text at 4.4:1 in
11 px caps, a mid tone accent as text at 3.7:1, muted text that passes on the page but fails on a
card.

## 5. Icons

- One outline family (for example Lucide), stroke 1.5 px, rounded caps.
- 16 px next to 13 to 14 px text (icon ink height 1.3 to 1.5x the cap height); 20 px in
  navigation if nav text is 14 to 15 px.
- Coloured like the text level of their label; the active nav icon may take the accent.
- Filled shapes only for status (check, warning triangle, live dot, severity bars).
- Placement: leading in labelled buttons and nav items; type icon before column header text;
  kebab at the far right of rows and card headers.
- Icon-only: sort, filter, group, search, view options, close, copy, more, favourite, sign out.
  Always with `aria-label` and tooltip, hit area 32 to 40 px (44 on touch).

## 6. Layout and placement

- **Title row:** title left, primary button right, vertically centred on the title line, not on
  a paragraph below it.
- **Under the title:** one line of muted subtext, then a fixed 24 to 40 px, then the first card.
- **Tool row inside the card:** tabs or chips left, icon tools right in the order sort, filter,
  group, search, view; counts on tabs and chips.
- **Sidebar:** logo or product name, groups with small uppercase labels (label to first item
  less than 0.7x the gap from the previous group), icon plus label per item, account button
  pinned to the bottom opening a popover (settings, language, help, legal, sign out).
- **Side panel** for details: floating with 8 px margin and rounded corners over a dimmed page,
  40 px header with title and close, 16 px padding.
- **Settings pages:** two columns on desktop, left third for section title, one line of help and
  the section action, right two thirds for the fields or key value rows.
- **Density by use:** dense tables (36 to 44 px rows) for many records; two line list rows for
  few rich records.
- **Footer** (public pages only): centred brand, one row of links separated by whitespace,
  three slot meta row; identical structure in light and dark, only tokens swap. Inside the app
  there is no footer; legal links sit in the account menu.

## 7. Radius and elevation

- One radius family: cards, tables, panels 8 to 12; buttons and inputs 6 to 10; pills full.
  Inner radius smaller than outer radius.
- No shadows on cards in light theme; a soft shadow only on floating layers (popover, panel,
  dialog). Dark theme uses borders, not shadows.

## 8. Visual weight

Weight is how strongly an element separates from its surface: fill, border, size, text weight,
contrast, position, isolation, uniqueness. Treat weight as a **budget per card**: most of it
goes to the deciding value and the one action, a medium share to the grouping container,
everything else stays at the lowest level that still passes contrast.

Before and after evidence:

- **Form:** the improved version removed four of eleven elements and the grey input fills, so
  the action became the only filled shape and the title the only large text. (It also replaced
  labels with placeholders, which costs recall and accessibility; keep visible small labels.)
- **Plan card:** the improved version grouped plan name, audience, price, billing condition and
  the action into one tinted decision zone, moved the action from 80 to 38 percent of the card
  height directly under the price, and listed included and excluded features below with one
  marker each.
