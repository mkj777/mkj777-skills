# Components

Anatomy of the recurring building blocks. Values come from [visual-system.md](visual-system.md)
and are mapped onto project tokens through the project profile.

## App shell

```
+----------+---------------------------------------------------------+
| Product  |  Title                                    [+ Primary]   |
|          |  One line of scope, muted                               |
| GROUP    |                                                         |
| (i) Item |  +---------------------------------------------------+  |
| (i) Item |  | (Tab 12) (Tab 3) (All)        [s][f][g][q][v]      |  |
|          |  |---------------------------------------------------|  |
| GROUP    |  | content                                           |  |
| (i) Item |  +---------------------------------------------------+  |
|          |                                                         |
| [Account >] |                                                      |
+----------+---------------------------------------------------------+
```

- Sidebar 240 to 248 px, groups with small uppercase labels, icon plus label per item, counts
  or a dot where something waits. Active item: two signals (text level plus accent marker or
  icon).
- Account button at the bottom (avatar, name, role, chevron) opens a popover: settings,
  language, help, legal, sign out. Sign out is never a loose text link.
- Mobile: top bar with product mark and a menu icon; the drawer repeats groups, counts and the
  account button.

## Page header

- Title: the navigation label, optionally with a count ("Open jobs 13", "Bookings today 8").
  States and greetings go into the subtext or the first card.
- One line of scope ("All locations, last 30 days"). No process explanations.
- One primary action on the title row, right aligned to the content edge.

## Card

- Card surface, 1 px hairline border, radius from the family, padding 16 or 24 for the whole
  product. Toolbar padding 12 by 16 with a hairline below.
- Header variant: title left, count right as strong number plus muted noun ("2 active links"),
  optional "View all" link or one action.
- Empty, loading and error render inside the same card.

## Toolbar

- Left: segmented tabs (track fill, raised active item) or filter chips with counts
  ("Received 4"). "All" last or first, consistently.
- Right: icon buttons in the order sort, filter, group, search, view options; search may expand
  inline.
- One control height for everything in the toolbar.
- Mobile: chips in one horizontally scrollable row, search as an icon that expands.
- Selection replaces the toolbar with a bulk bar ("3 selected", actions, clear).

## Table

- Header row same height as body rows, sentence case labels at medium weight in the secondary
  text level, a 16 px type icon before each label, sort indicator on sortable columns.
- Checkbox column first when bulk actions exist, then the identifying column.
- Text left, numbers right with `tabular-nums`, references people use (invoice, booking or
  order numbers) in mono; database IDs and slugs stay out.
- Hairline row separators, no zebra, hover fill one step off the card.
- Rows 36 to 44 px, one line, ellipsis plus tooltip for long values.
- Inactive, closed, cancelled rows: whole row in muted text and a faint fill; the status pill
  keeps its tone.
- Last column: one inline action at most, then a kebab menu. Row click opens the side panel.
- Column picker in the header's kebab; sparse columns hidden by default.
- Sort, filter and tab stored in the URL. Default sort is "what must be handled first".
- Mobile: becomes a row list (see below).

## Row list (mobile and rich lists)

```
Name or title                                  (o) Status
Deciding attribute . second attribute               meta >
```

- Line 1: primary text plus status pill. Line 2: two deciding attributes in muted text.
- Tap opens a full screen sheet with all fields and actions. No buttons inside the row.
- Rich desktop list row: primary line (mono allowed for identifiers) with a status badge and a
  copy icon, secondary line in secondary grey, meta column, a bordered stat pill, kebab.

## Chips and pills (four recipes)

| Recipe | Look | Use |
|---|---|---|
| Status | pale tint of the semantic hue, icon plus word in the dark text of that hue, full radius, 22 to 24 px | state of a record |
| Category | neutral fill or outline, 8 px coloured dot, neutral text | department, location, type |
| Attribute | outline, neutral text, optional dot | tags, filters |
| Severity or priority | outline, coloured icon shape (bars, triangle), neutral text | urgency |

One status vocabulary per product, kept in code as a single map from state to label, icon and
tone. The normal state of an object may show nothing, so exceptions stand out.

## Metric card

```
Label >
32,142                 ~~~~/\~~/\/\~~~
+12 % vs last month
```

- Muted label with a chevron when it drills in; the whole card is the link.
- Big number 2 to 2.4x the label, bottom left; comparison in words with a sign.
- Optional sparkline over the right 50 to 60 percent, one hue, no axes.
- 16 px padding. At most one row of metric cards per page, and only metrics that belong to the
  page and are not already filter counts.
- Mobile: one compact row of two or three numbers, never full width stacks.

## Chart card

- Title, big number plus muted unit ("214 total"), "View all" link.
- One hue per series, at most three faint gridlines, axis labels muted at 0.65 to 0.8x body.
- A chart needs a question it answers; otherwise it is not built.

## Side panel and timeline

- About 25 percent of the viewport, floating with 8 px margin and rounded corners over a dimmed
  page; header 40 px with title and close; 16 px padding; Escape closes; URL reflects the record.
- State banner on top in the info tint ("Waiting for approval").
- Timeline: state dot, semibold event title, absolute and relative time ("Today, 14:13 · 4 hours
  ago"), details in a nested bordered key value block with a fixed label column (about 88 px),
  one secondary action per event.
- Mobile: full screen sheet with a back button.

## Checklist with progress

- Header: what it is for, remainder ("10 fields missing"), collapse control.
- One row per item: open circle or filled check, label, missing count, one action per row.
- Done items checked and muted, not removed.
- Footer: "4 of 6 complete" plus a bar in the accent.
- The checklist is the single full source of that progress; elsewhere only a dot or count.

## Forms

- Visible label above each field (small, medium weight), 4 to 8 px above the field, aligned to
  the field edge. Placeholders show format only.
- Input: neutral border at 3 to 4.5:1, no grey fill needed; hover darker; focus accent border
  plus ring.
- Helper or error text 4 to 10 px under the field at the text inset; the error replaces the
  helper in the same slot.
- Required fields marked consistently; optional fields say "optional" in the label.
- Missing required fields: warn tint and a per section count before submit, error tone only
  after a failed submit.
- Single choice from more than six options: select or radio list, not a wall of chips.
- Save: per section, or a sticky bar with save state ("Unsaved changes", "Saved 2 min ago") that
  reserves its height. Leaving with unsaved changes asks.
- Settings pages: two columns on desktop (section title, help and action left; fields right).

## Dialogs and confirmations

- Title names the action and the object ("Block the account of Alex Kim?").
- Body states the consequence in one or two sentences.
- Sections divided by hairlines and small sentence case labels.
- Footer band (one step tinted) with cancel left or secondary, and the action labelled with the
  verb ("Block account"), danger tone only for destructive actions.

## Plan, subscription and usage

- Plan or subscription card: name, audience or current status, price with its billing condition
  attached ("15 per month, billed yearly", currency and order per locale), next charge date, and the action, grouped as one
  decision zone at the top; included features below with one check marker each; excluded
  features with a distinct marker, muted text and an accessible "not included".
- Recommended or only option: solid button. Alternatives beside it: outline. Current plan:
  disabled "Current plan".
- Usage list: icon or progress ring, label, "used / limit" right aligned; at the limit the ring
  turns to the warn tone; not included says "Not included" with an upgrade link.

## Empty, loading, error

- Empty: inside the card, one sentence with the reason (and the blocker if any), one action.
  Secondary empty sections shrink to one line.
- Loading: skeleton blocks in one neutral tone in the shape of the real layout, after about
  300 ms.
- Error: what happened, what to do, retry button, input kept.

## Onboarding hints

- Inverted small card with a caret, title, one sentence, "Dismiss". One at a time, never over
  the primary action, never again once dismissed.

## Share and permissions

- Invite field with embedded role select and a labelled "Invite" button.
- General access as one row with an icon tile, title and muted description.
- People rows: avatar, name, email, role select; owner marked and not editable.
- Footer band with the link and "Copy link".
