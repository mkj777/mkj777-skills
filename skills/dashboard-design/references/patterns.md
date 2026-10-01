# Patterns

Concrete building blocks for the rules in [SKILL.md](../SKILL.md). Each pattern lists what it
is for, its anatomy, and what agents tend to get wrong.

Visual reference: the "Dashboard Flaws" Figma board (employee table, proposal activity panel,
incident tracking with chart, onboarding checklist, sharing dialog). Its properties are
described in the patterns below; the TalentBridge tokens replace its colours.

## Role overviews

The overview is the page each role lands on. It answers the role card question, nothing else.

### Applicant (Bewerber, at TalentBridge the paying customer)

Question: "Can I apply, and where do my applications stand?"

Order, top to bottom:

1. **Blocker first, if any.** Profile incomplete: the readiness checklist is the page. Title
   carries the state ("Noch 10 Angaben bis zur ersten Bewerbung"), primary action
   "Profil vervollständigen".
2. **Applications in progress**, newest status change first, each with status pill and the
   next step ("Rückmeldung bis 05.10." or "Termin am 07.10., 10:00").
3. **Matching jobs**, three at most, link to the job portal.
4. **Counselling offer** as one secondary row, not a competing dark card.

Empty sections below a blocker collapse into one line that names the blocker:
"Bewerbungen und Vorschläge erscheinen, sobald dein Profil vollständig ist."

### Company client (books staff)

Question: "Is my staff for the next assignments covered?"

1. **Next assignments** with coverage state ("8 von 10 besetzt"), the gaps first.
2. **Things waiting on the client**: bookings to confirm, timesheets to sign, invoices due.
   Each row has its action inline.
3. **Book staff** is the primary action.
4. Invoices and history are navigation items, not overview content.

### Back office (Vermittler, Disponent, Personalberater, Admin)

Question: "What is waiting for me today?"

1. **Work queue**, not metrics. Tabs with counts: "Neue Bewerbungen 12", "Termine zu
   bestätigen 3", "Buchungen offen 5", "Profile prüfen 7". Default tab is the one with the
   oldest unhandled item.
2. **Table of the selected queue**, oldest first, row click opens the side panel, bulk
   actions on selection.
3. **Today's schedule** (appointments, assignments starting today) as a compact list beside or
   below.
4. Metrics only if someone decides something with them, each linked to its filtered list.

## Status vocabulary

One table per project, kept in code as a single map (`status.ts` or similar) from state to
label, icon and tone. Components never pick colours for status themselves.

| Domain | State | Label (UI) | Icon | Tone |
|---|---|---|---|---|
| Profile | incomplete | Unvollständig | circle-dashed | warn |
| Profile | complete | Vollständig | check | ok |
| Application | submitted | Eingegangen | send | info |
| Application | in_review | In Prüfung | eye | info |
| Application | interview | Gespräch geplant | calendar | info |
| Application | accepted | Zusage | check | ok |
| Application | rejected | Absage | x | neutral (muted row) |
| Application | withdrawn | Zurückgezogen | undo | neutral (muted row) |
| Appointment | requested | Angefragt | clock | warn |
| Appointment | confirmed | Bestätigt | check | ok |
| Appointment | done | Stattgefunden | check-check | neutral |
| Appointment | cancelled | Abgesagt | x | neutral (muted row) |
| Booking | open | Offen | circle | offen |
| Booking | partially_staffed | Teilweise besetzt | circle-half | warn |
| Booking | staffed | Besetzt | check | ok |
| Booking | cancelled | Storniert | x | neutral (muted row) |
| Job posting | draft | Entwurf | pencil | neutral |
| Job posting | active | Aktiv | circle-dot | ok |
| Job posting | expiring | Läuft in 2 Tagen ab | clock | warn |
| Job posting | expired | Abgelaufen | clock-off | neutral (muted row) |
| Job posting | archived | Archiviert | archive | neutral (muted row) |
| Account | active | (nothing shown) | | |
| Account | unconfirmed | Adresse unbestätigt | mail-question | warn |
| Account | blocked | Gesperrt | ban | danger |
| Invoice | open | Offen | file | info |
| Invoice | overdue | Überfällig | alert-triangle | danger |
| Invoice | paid | Bezahlt | check | ok |

The normal state of an object is often shown as nothing at all (an active account), so the
exceptions stand out (rule 14 in SKILL.md).

Rejections, cancellations and expiry are neutral, not red: nothing went wrong in the system, and red
on an applicant's own rejection is needlessly harsh. Danger is reserved for overdue, failed and
broken.

## Status pill

- Tinted background (`--status-*-bg`), text and icon in `--status-*`, optional 1 px line
  (`--status-*-line`).
- Icon 14 px, label at `text-xs` or `text-sm`, medium weight, radius full.
- Never only a dot. A dot alone is allowed in navigation as a "needs attention" marker, and
  then it has an accessible label.

## Category chip

- Neutral background or outline, neutral text, optional 8 px coloured dot in front.
- Used for location, industry, department, employment type.

## App shell and sidebar

```
[Logo, area label]
Nav item                      [count]
Nav item (active, tinted)     [count]
...
(spacer)
[Avatar] Name                 [log out icon]
         Team, location
[language icon]
```

- Navigation items show a count when something waits there (back office) or a dot when the
  person has to act (Kundenbereich). Count and dot have an accessible label.
- Log out, language and help are icon buttons with `aria-label` and tooltip, never text links.
- The footer with legal links sits at the end of the page content, muted, not in a fixed bar.

## Page shell

```
Title as number or state                                   [Primary]
One line of scope, muted
                    24 px
+--------------------------------------------------------------+
| [Tabs or filter chips with counts]   [Search] [Sort] [View] |
|--------------------------------------------------------------|
| Content                                                      |
+--------------------------------------------------------------+
                    16 px
+--------------------------------------------------------------+
| Next card                                                    |
+--------------------------------------------------------------+
```

- One component for every page. Title `text-3xl` semibold, subtext `text-sm` muted, one line.
- Header and cards share one content width. Forms limit their field width inside the card.
- Card: `--card` background, 1 px `--border`, `--radius`, padding 24 px (16 px on mobile),
  toolbar padding 12 px 16 px with a separator below. Tables sit edge to edge inside the card.
- Cards stack with 16 px gap; sections with their own heading inside the card, not between cards.
- Empty, loading and error states render inside the same card.

## Row actions

```
| ... columns ...                     | [Most used action] [more icon] |
```

- At most one inline action, as a ghost button or icon button. Everything else in the
  overflow menu, ordered by frequency, destructive last and in danger text, separated.
- Destructive actions confirm in a dialog that names the object and the consequences, with the
  destructive button labelled by the action ("Konto sperren"), never "OK".
- Bulk actions appear in place of the toolbar when rows are selected.

## Table

From the Figma reference, kept:

- Column headers with a type icon (hash for numbers, calendar for dates, envelope for email).
- Numbers right aligned, text left aligned, IDs in mono.
- Only horizontal separators, row height about 40 px, checkbox column in front.
- Long values truncated with ellipsis, full value in a tooltip and in the side panel.
- Inactive rows muted across the whole row, status pill keeps its colour.
- Column settings at the far right of the header row.

Added for the back office:

- Sticky header, sticky first column on narrow screens.
- Selection reveals a bulk action bar replacing the toolbar, with the count ("3 ausgewählt").
- Sort, filter and tab are reflected in the URL so a view can be shared and reloaded.
- Pagination or virtual scrolling at more than 100 rows; show the total.
- Mobile: the table becomes a list of rows with the two decisive attributes and the status,
  not a horizontally scrolling table.

## Job list (applicant side)

The current card grid hides the decision attributes. A job row shows, in this order of weight:

1. Title (`text-base` semibold)
2. Wage and employment type at body size ("ab 16 €/Std · Vollzeit")
3. Location and distance ("Düsseldorf · 12 km")
4. State relative to the person: "Beworben am 28.09." pill, or "Profil unvollständig" hint
   when applying is blocked.

Filters the applicant actually uses: location or radius, employment type, start date. Show the
active filters as removable chips, and the result count in the title.

## Metric

```
Label                                   Ansehen >
214   gesamt, +18 % zum Vormonat
[small chart only if the trend matters]
```

- Number large, label and period small, comparison in words or with a sign, not colour alone.
- The whole block is a link to the filtered list.
- One chart colour (brand), gridlines faint, axis labels small and muted.

## Side panel and activity

From the Figma reference:

- Opens from the right over the work surface, the list stays visible and scrollable.
- Info banner on top for the current state of the object ("Wartet auf Bestätigung durch den
  Kunden").
- Timeline of events, newest first, each with absolute and relative time, actor with avatar,
  key value block (Eingereicht von, Datensätze, Zusammenfassung) and one follow-up action.
- Close with Escape and an X; the URL reflects the open record.

## Readiness checklist

From the Figma reference and the current applicant overview, combined:

- Header: what this is for ("Bereit für Bewerbungen"), remainder ("Noch 10 Angaben"),
  progress bar with "4 von 6 erledigt".
- One row per section, with the count missing ("4 fehlen") and one action per row
  ("Ergänzen", "Hochladen").
- Done rows checked and muted, not removed.
- This checklist is the single full source of profile progress. The sidebar shows only a
  compact pointer that links here.

## Empty state

```
[Reason in one sentence.]
[Action]
```

- Dashed or plain container at the size of one row when secondary, larger only when the empty
  state is the whole page.
- The sentence names the cause from the person's side, including a blocker if there is one.
- No illustration in the back office. In the applicant area a small icon is fine.

## Form section

From the current profile page, kept:

- Sections as cards with a header that counts missing required fields ("4 fehlen") in warn tone.
- Missing required fields tinted in warn background before submitting.

Changed:

- Save bar: sticky at the bottom of the viewport, full width of the content column, shows the
  save state on the left and the primary button on the right, with matching bottom padding on
  the page so it never covers a field or an upload action.
- Single choice from many options (status: Schüler:in, Student:in ...) as a select or a
  radio list when there are more than six options; chips only up to six.
- Optional fields say "optional" in the label, not only in the placeholder.

## Sharing and permissions

From the Figma reference:

- Invite field with role select and one primary button.
- General access as one line with icon and explanation.
- People list with name, email and role select per row; the owner marked, not editable.
- Copy link as the closing action at the bottom.
