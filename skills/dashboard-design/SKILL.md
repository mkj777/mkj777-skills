---
name: dashboard-design
description: Rule set for logged-in interfaces of booking systems, job portals and staffing agencies, meaning the applicant dashboard, the client area and the back office. Derives every view from the person using it (role, question, next action, blocker), then enforces hard, checkable rules for the primary action, status, colour, tables, cards, metrics, empty states, forms and detail views. Use this skill for "build a dashboard", "design the back office", "rework the overview", "applicant area", "client portal", "admin UI", "table or cards", "status display", "empty state", "the dashboard feels cluttered", and for every review of such screens. Not for marketing sites or landing pages; that is vbelt-design.
---

# Dashboard Design

> **Treat the UI like the person using it, not the designer designing it.**

A dashboard is not looked at, it is used: daily, under time pressure, often on a phone. The
person arrives with a question ("Can I apply yet?", "Who is missing from tomorrow's shift?",
"Which applications are waiting for me?") and wants to leave with an answer and an action.
Everything that does not serve that question costs them time.

Without rules, agents reliably build the same wrong dashboard: a greeting on top, four
colourful metric tiles with no context, cards instead of a table, three equally loud buttons,
status shown as colour only, empty sections at full size, a spinner. This skill prevents that.

## Workflow

1. **Write the role card** (section 1) before a single line of UI exists.
2. **Derive the view**: page anatomy, primary action, presentation form (section 2 and
   [references/patterns.md](references/patterns.md)).
3. **Build against the hard rules** (section 3). Take project tokens from the project
   profile; for TalentBridge that is [references/talentbridge.md](references/talentbridge.md).
4. **Pre-flight** (section 5) for every view and every role, with real states: empty,
   partial, full, error, no permission.

For a review instead of a build: still do step 1, then check every view against sections 3
and 5 and deliver the findings as a table (rule, location, what the user experiences, fix).

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

## 2. Page anatomy

Every view has the same order. Know one page, know them all.

1. **Location**: active navigation item, breadcrumb on deeper levels.
2. **Title**: says what is here, ideally as a number or state ("13 offene Stellen",
   "4 Bewerbungen warten"). At most one line of description below it.
3. **Action row**: tabs or filters on the left, tools on the right (search, sort, view),
   exactly one primary action at the far right.
4. **Work surface**: the list, table, form or checklist.
5. **Details** open as a side panel over the work surface as long as the person keeps
   working in the list afterwards. A separate page only when editing takes longer than a glance.

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

### Information

6. **Every piece of information has one source.** A value (progress, price, missing fields)
   appears in full in one place and at most once more as a compact pointer that leads there.
   The same progress three times is two times too many.
7. **A data field has a fixed meaning.** If the wage is missing, the slot says
   "Lohn auf Anfrage", not the start date as a stand-in. Missing values read "nicht angegeben"
   in muted colour, never blank, never a lone hyphen.
8. **The comparison attribute is readable.** Whatever the person decides on (location, wage,
   date, status) is set at body size and full contrast, never only as a small caps eyebrow.
9. **Numbers are data.** `font-variant-numeric: tabular-nums`, right aligned in tables, with a
   unit, German format (`14,50 €/Std`, `01.10.2026`). IDs and codes in mono.
10. **Time twice where it matters.** In timelines and activity both absolute and relative
    ("Heute, 14:13 · vor 4 Stunden"). Deadlines as time left plus date ("noch 2 Tage, bis 03.10.").
11. **No metric on its own.** Every number has a label, a reference period or comparison, and a
    click target that opens the filtered list behind it. A number without an action is decoration.

### Status and colour

12. **Status is icon plus word plus tone colour.** Colour is never the only carrier. Every
    state lives in the project's central status vocabulary with exactly one rendering
    (see [references/patterns.md](references/patterns.md#status-vocabulary)).
13. **Status and category look different.** Status: tinted pill with icon. Category
    (industry, location, department): neutral chip, at most one coloured dot.
14. **Colour is rationed.** The interface is neutral. Brand colour only for the primary action,
    active navigation, progress and links. Status colours only for status. No colourful tiles,
    no colour as decoration, no gradients on controls.
15. **Warning before error.** Missing required fields are a hint before submitting (warn
    tone), and an error only after a failed submit (danger tone). Red is for things that went wrong.
16. **Done things step back but do not disappear.** Inactive, cancelled, completed records are
    muted across the whole row, stay visible and can be hidden by filter. Only the status
    carries colour.

### Presentation

17. **Table before cards.** More than six objects of the same kind that get compared
    (applicants, bookings, jobs in the back office, invoices) are a table or a dense list.
    Cards only for few, dissimilar or image driven objects.
18. **The back office is dense.** Row height 40 to 44 px, checkbox for bulk actions, sortable
    columns, filters and sort stored in the URL, tabs show their count ("Neu 12"). Default
    sort is "what has to be handled first" (oldest open first, then deadline), never alphabetical.
19. **Applicants and clients are mobile first.** Every view works at 360 px width without
    horizontal scrolling, touch targets at least 44 px, primary action within thumb reach.
20. **One thing per section.** A card or section answers one question. A section with nothing
    to say shrinks to one line or goes away (rule 22).

### States

21. **Loading shows the shape.** Skeletons in the real layout, no centred spinner. The skeleton
    appears after 300 ms without data, not before (no flicker).
22. **Empty explains why and what now.** Every empty state names the reason and an action. If
    the reason is a blocker, name the blocker ("Bewerben kannst du, sobald dein Profil
    vollständig ist. Noch 10 Angaben."). Empty secondary sections are one line, not a full card.
23. **Errors say what happened and what now.** No technical messages, no codes without text.
    Input is preserved. Retry is a button, not an instruction.
24. **Saving is visible.** Forms show their state: "Nicht gespeichert", "Speichert ...",
    "Gespeichert vor 2 Min". Leaving with unsaved changes asks first.
25. **Progress with remainder.** Checklists show "4 von 6 erledigt" plus a bar, open items with
    their own action per row, done items checked and muted.

### Tone

26. **No marketing in the logged-in area.** Explanations are one sentence at most, the rest
    behind "Mehr erfahren" or on the public site. A price appears in one place.
27. **Greeting only with content.** "Hallo Max" on its own is not information. If there is a
    greeting, it carries the state: "Hallo Max, noch 10 Angaben bis zur ersten Bewerbung."
28. **The person's language.** Applicants are addressed informally if the product does,
    the back office is terse and professional. No internal terms (table names, enum values)
    in the interface.

## 4. Never built

- Four metric tiles in four colours as the entry point, without click target or comparison.
- Charts nobody needs for a decision. A chart needs a question it answers; then the `dataviz`
  skill applies.
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
   "urgent first"?
9. **Keyboard**: Is everything reachable by Tab in a sensible order, with visible focus?
10. **Contrast**: Text at least 4.5:1, including muted text on tinted surfaces.

## What this skill does not do

- No marketing pages, no hero, no landing page. That is `vbelt-design`.
- No detailed chart design. That is `dataviz`; this skill only decides whether a chart is
  needed at all.
- No brand development. Colours and fonts come from the project profile; if there is none, it
  is first created from the project's CSS (template:
  [references/talentbridge.md](references/talentbridge.md)).
