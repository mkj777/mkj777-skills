---
name: dashboard-design
description: Finds the usability problems in logged-in interfaces of booking systems, job portals and staffing agencies (applicant or customer area, client area, back office) and solves them with a defined target design language. Derives every view from the person using it (role, question, next action, blocker), checks it against hard, checkable rules for the primary action, status, colour, tables, cards, metrics, empty states, forms, detail views and mobile, and delivers findings plus a redesign spec per view. Use this skill for "build a dashboard", "design the back office", "rework the overview", "applicant area", "client portal", "admin UI", "table or cards", "status display", "empty state", "the dashboard feels cluttered", and for every review of such screens. Not for marketing sites or landing pages; that is vbelt-design.
---

# Dashboard Design

> **Treat the UI like the person using it, not the designer designing it.**

A dashboard is not looked at, it is used: daily, under time pressure, often on a phone. The
person arrives with a question ("Can I apply yet?", "Who is missing from tomorrow's shift?",
"Which applications are waiting for me?") and wants to leave with an answer and an action.
Everything that does not serve that question costs them time.

Without rules, agents reliably build the same wrong dashboard: a greeting on top, four
colourful metric tiles with no context, cards instead of a table, three equally loud buttons,
status shown as colour only, empty sections at full size, a spinner. This skill finds those
problems and replaces them with a better design.

## Files

| File | What it holds |
|---|---|
| this file | role card, page shell, hard rules, pre-flight, workflow |
| [references/target-design.md](references/target-design.md) | the target design language every fix moves towards, desktop and mobile |
| [references/patterns.md](references/patterns.md) | building blocks: role overviews, status vocabulary, shell, table, row actions, panel, forms |
| [references/talentbridge.md](references/talentbridge.md) | project profile: tokens, roles, current findings. Other projects get their own profile in the same shape. |

## Workflow

### Mode A: review and redesign (default when screens or a running app exist)

1. **Role card** (section 1) for every role whose screens are in scope.
2. **Inventory**: list every view per role, desktop and mobile, with the states that were
   actually seen (empty, partial, full). Missing states are noted as "not seen", not guessed.
3. **Findings**: check each view against section 2 (shell) and section 3 (rules). One row per
   finding in the project profile: id, rule, where, what the user experiences, fix. Write the
   user experience as the person would say it, not as a design term.
4. **Redesign spec per view**, in the target design language: a layout sketch (ASCII is fine),
   what moves where, which pattern replaces what (see "Typical replacements" in
   target-design.md), the primary action per state, and the mobile variant. Fix the cause
   across views (one shell, one status map, one button) before fixing single screens.
5. **Pre-flight** (section 5) against the spec, not against the old screen.
6. Only when asked: implement, view by view, shared components first (shell, status pill,
   table, row actions), then the pages.

### Mode B: build a new view

1. Role card. 2. Shell and pattern from patterns.md. 3. Build against section 3 in the target
design language. 4. Pre-flight with real states.

Fixes always move towards [references/target-design.md](references/target-design.md), never
towards a new private idea per screen. The reference sets the character; it is not copied 1:1.

## 1. The role card

Four lines for every role that sees the view. Nothing gets built without this card.

| Field | Question | Example applicant | Example back office |
|---|---|---|---|
| **Question** | What question does the person open the page with? | "Can I apply, and where do my applications stand?" | "What is waiting for me today?" |
| **Next action** | What should they have done afterwards? | Finish the profile, then apply | Screen new applications, confirm appointments |
| **Blocker** | What is stopping them right now? | 10 required fields missing | nothing, or: client has not confirmed a booking |
| **Rhythm and device** | How often, how long, on what? | a few times, briefly, mostly phone | daily, for hours, desktop |

What follows directly:

- The **primary action** of the view is the next action. If there is a blocker, the primary
  action is resolving the blocker, not the underlying wish.
- The **first screen** answers the question. Greeting, marketing and explanations come after,
  or not at all.
- **Rhythm sets density.** Daily and long (back office) means dense, tabular, keyboard
  driven. Rare and short (applicant, client) means guided, mobile first, one thing per screen.

The three roles of a booking and job portal and what their overview shows are in
[references/patterns.md](references/patterns.md#role-overviews).

## 2. Page shell

Every page is built from the same three parts, in the same order, with the same measurements.
Know one page, know them all. The shell is one component (`<PageShell>` or similar), never
rebuilt per page.

```
Header      Title                                         [Primary action]
Subtext     One line, muted
            (gap 24 px)
Card        [Toolbar: tabs or filters left, tools right]
            Content: table, list, form, checklist or empty state
```

1. **Header**: title says what is here, ideally as a number or state ("13 offene Stellen",
   "4 Bewerbungen warten"). The primary action sits on the title line at the far right, on
   every page in the same place. Active navigation item marks the location; breadcrumb only on
   deeper levels.
2. **Subtext**: exactly one line, muted, at most about 80 characters. It states the scope or
   the current filter ("Alle Standorte, letzte 30 Tage"), not how the feature works. Anything
   longer belongs in a "Mehr erfahren" popover or in the dialog of the action it explains.
   No subtext is better than a filler subtext ("Dein Konto im Backoffice.").
3. **Card**: all content lives in cards that look identical everywhere: same background,
   border, radius, padding, same width as the header. Filters and tabs sit inside the top of
   the card, not floating between header and card. Several cards stack with one fixed gap.
   An empty state is the same card with the empty state inside, not a different dashed box.
4. **Details** open as a side panel over the card as long as the person keeps working in the
   list afterwards. A separate page only when editing takes longer than a glance.

Nothing goes between subtext and the first card except a single metric row that passes rule 13.

## 3. Hard rules

Every rule can be checked on the screen. A broken rule is a finding, not a matter of taste.

### Action

1. **Exactly one primary action per view.** Visible as the only filled button in the primary
   colour. Everything else is secondary (outline or ghost) or a text link.
2. **The primary action follows the state.** Profile incomplete: "Profil vervollständigen",
   not "Jobs durchsuchen". No open application: "Stellen ansehen". When the state changes,
   the action changes in the same place.
3. **One primary colour across the product.** Same label means same component, same colour,
   same size. The same button once black and once green is a finding.
4. **Actions are named after what happens**, as a verb: "Lebenslauf hochladen", not "Weiter"
   or "Hier". The same thing has the same word everywhere.
5. **Nothing covers content.** Floating save buttons and sticky bars reserve their height as
   padding at the end of the page. No element hides another control.
6. **Meta actions are icon buttons, content actions are words.** Log out, language, help,
   close, more, settings of a table: icon button with `aria-label` and tooltip, 36 to 40 px hit
   area. Actions on the content itself ("Stelle anlegen", "Termin bestätigen") stay labelled
   buttons. A text link "Abmelden" next to the user name is a finding.
7. **Row actions live in one overflow menu.** A table row carries at most one inline action
   (the one done most often); everything else goes into a "more" icon button at the row end
   and into the side panel. Destructive actions ("Sperren", "Löschen", "Schließen") are never
   inline in the row and always confirm, saying what will happen.

### Information

8. **Every piece of information has one source.** A value (progress, price, missing fields)
   appears in full in one place and at most once more as a compact pointer that leads there.
   The same progress three times is two times too many.
9. **A data field has a fixed meaning.** If the wage is missing, the slot says
   "Lohn auf Anfrage", not the start date as a stand-in. Missing values read "nicht angegeben"
   in muted colour, never blank, never a lone hyphen.
10. **The comparison attribute is readable.** Whatever the person decides on (location, wage,
   date, status) is set at body size and full contrast, never only as a small caps eyebrow.
11. **Numbers are data.** `font-variant-numeric: tabular-nums`, right aligned in tables, with a
   unit, German format (`14,50 €/Std`, `01.10.2026`). IDs and codes in mono.
12. **Time twice where it matters.** In timelines and activity both absolute and relative
    ("Heute, 14:13 · vor 4 Stunden"). Deadlines as time left plus date ("noch 2 Tage, bis 03.10.").
13. **No metric on its own.** Every number has a label, a reference period or comparison, and a
    click target that opens the filtered list behind it. A number without an action is decoration.
    A metric belongs to the page it sits on ("Aktive Abos" does not belong on Bewerbungen),
    and a metric that counts the same thing as a filter chip is replaced by the chip's count.
14. **A column that never varies is noise.** If every row says "Aktiv" or shows a dash, the
    column shows only the exceptions ("Gesperrt", "Unbestätigt") and stays empty otherwise,
    or goes away. The same holds for repeated words in a cell: "2", not "2 Bewerbungen" in a
    column titled "Bewerber".
15. **One line per value.** Emails, IDs and URLs never wrap mid-word; they truncate with
    ellipsis and show in full on hover and in the panel. A row has one main line and at most
    one muted meta line.

### Status and colour

16. **Status is icon plus word plus tone colour.** Colour is never the only carrier. Every
    state lives in the project's central status vocabulary with exactly one rendering
    (see [references/patterns.md](references/patterns.md#status-vocabulary)).
17. **Status and category look different.** Status: tinted pill with icon. Category
    (industry, location, department): neutral chip, at most one coloured dot.
18. **Colour is rationed.** The interface is neutral, ink on paper. The primary button has the
    one primary colour the profile defines (TalentBridge: ink). The accent colour only marks
    active navigation, progress, links and focus. Status colours only for status. No
    colourful tiles, no colour as decoration, no gradients on controls.
19. **Warning before error.** Missing required fields are a hint before submitting (warn
    tone), and an error only after a failed submit (danger tone). Red is for things that went wrong.
20. **Done things step back but do not disappear.** Inactive, cancelled, completed records are
    muted across the whole row, stay visible and can be hidden by filter. Only the status
    carries colour.

### Presentation

21. **Table before cards.** More than six objects of the same kind that get compared
    (applicants, bookings, jobs in the back office, invoices) are a table or a dense list.
    Cards only for few, dissimilar or image driven objects.
22. **The back office is dense.** Row height 40 to 44 px, checkbox for bulk actions, sortable
    columns, filters and sort stored in the URL, tabs and filter chips show their count
    ("Neu 12", "Eingegangen 4"). Default sort is "what has to be handled first" (oldest open first, then deadline), never alphabetical.
23. **Applicants and clients are mobile first, and nothing breaks on a phone.** Every view,
    back office included, works at 360 px width without horizontal scrolling, touch targets at
    least 44 px. Below 768 px tables become row lists (line 1 name and status, line 2 the two
    deciding attributes), records open as full screen sheets, filter chips scroll in one row,
    metric tiles never stack full width above the content. A clipped table is a finding.
24. **One thing per section.** A card or section answers one question. A section with nothing
    to say shrinks to one line or goes away (rule 26).

### States

25. **Loading shows the shape.** Skeletons in the real layout, no centred spinner. The skeleton
    appears after 300 ms without data, not before (no flicker).
26. **Empty explains why and what now.** Every empty state names the reason and an action. If
    the reason is a blocker, name the blocker ("Bewerben kannst du, sobald dein Profil
    vollständig ist. Noch 10 Angaben."). Empty secondary sections are one line, not a full card.
27. **Errors say what happened and what now.** No technical messages, no codes without text.
    Input is preserved. Retry is a button, not an instruction.
28. **Saving is visible.** Forms show their state: "Nicht gespeichert", "Speichert ...",
    "Gespeichert vor 2 Min". Leaving with unsaved changes asks first.
29. **Progress with remainder.** Checklists show "4 von 6 erledigt" plus a bar, open items with
    their own action per row, done items checked and muted.

### Tone

30. **No marketing in the logged-in area.** Explanations are one sentence at most, the rest
    behind "Mehr erfahren" or on the public site. A price appears in one place.
31. **Greeting only with content.** "Hallo Max" on its own is not information. If there is a
    greeting, it carries the state: "Hallo Max, noch 10 Angaben bis zur ersten Bewerbung."
32. **The person's language.** Applicants are addressed informally if the product does,
    the back office is terse and professional. No internal terms (table names, enum values)
    in the interface, and no technical details nobody acts on in the main view (URL slugs,
    database IDs, internal flags). They go into the side panel, if anywhere.

## 4. Never built

- Four metric tiles in four colours as the entry point, without click target or comparison.
- Charts nobody needs for a decision. A chart needs a question it answers; then the `dataviz`
  skill applies.
- Metric tiles above a table that repeat the counts of the filter chips below them.
- A stack of two or more buttons in every table row.
- Two filled buttons side by side. Two dark "feature" cards competing for attention.
- A spinner in the middle of the page.
- Tables with truncated content where the full value cannot be read via tooltip or panel.
- Modal dialogs for content that should be read next to the list.
- Placeholder data in screens under review ("Stelle 1", "test", "asdf"). Seed data is
  realistic, otherwise the layout is tested against the wrong lengths.

## 5. Pre-flight

For every view and every role before it counts as done. Every "no" is a finding.

1. **Five second test**: Does the first screen answer the question from the role card
   without scrolling?
2. **One primary action**: Is there exactly one filled primary button, and is it the next
   action or the blocker fix?
3. **Consistency**: Do identical actions have the same label, colour and shape everywhere?
4. **Status without colour**: Is every status still readable in greyscale (icon and word)?
5. **Duplicate sources**: Does any value appear more than twice on the screen?
6. **States**: Are empty, partial, full, loading, error and "no permission" built and looked
   at, with realistic data and one extra long name?
7. **Mobile** (applicant, client): 360 px, no horizontal scrolling, nothing covered.
8. **Density** (back office): Do 15 rows fit on a 900 px tall screen? Is the default sort
   "urgent first"? Does any column show the same value in every row?
9. **Keyboard**: Is everything reachable by Tab in a sensible order, with visible focus?
10. **Contrast**: Text at least 4.5:1, including muted text on tinted surfaces.
11. **Shell**: Does the page use the shared shell, with one line of subtext, content inside
    the standard card, same width and spacing as every other page?

## Output of a review

1. Role cards.
2. Findings table per area in the project profile (shared shell findings first).
3. Redesign spec per view with desktop and mobile sketch.
4. A short list of shared components to build first, in order.

## What this skill does not do

- No marketing pages, no hero, no landing page. That is `vbelt-design`.
- No detailed chart design. That is `dataviz`; this skill only decides whether a chart is
  needed at all.
- No brand development. Colours and fonts come from the project profile; if there is none, it
  is first created from the project's CSS (template:
  [references/talentbridge.md](references/talentbridge.md)).
