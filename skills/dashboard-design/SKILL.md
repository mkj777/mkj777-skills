---
name: dashboard-design
description: Design principles for logged-in product interfaces such as dashboards, back offices, admin areas, customer portals, booking systems and job portals. Treats the UI from the side of the person using it, then holds every screen to measurable rules for spacing, type, colour, contrast, icons, placement, components, states and mobile. Works on any project by mapping the project's own tokens onto the rule set first. Use this skill to build a new dashboard view, to review existing screens and redesign them, to set up a design system for a logged-in area, or when a dashboard, admin panel, internal tool, settings page or data table feels cluttered, inconsistent, hard to scan or broken on mobile; also for UI audits of such screens. Not for marketing pages or landing pages; detailed chart styling goes to a dataviz skill if one is installed.
---

# Dashboard Design

> **Treat the UI like the person using it, not the designer designing it.**

A dashboard is not looked at, it is used: often daily, under time pressure, sometimes on a
phone. The person arrives with a question and wants to leave with an answer and an action.
Everything on the screen either serves that question or costs them time.

The rules in this skill are generalized from measured reference designs (light and dark data
apps), from audits of real products, and from before and after comparisons. They describe a
character, not a look: **a quiet, neutral work surface where only data, state and the one next
action carry weight.** Brand, fonts and colours come from the project; the rules decide how they
are used.

## Files

| File | Use it for |
|---|---|
| this file | principle, workflow, the hard rules, pre-flight |
| [references/visual-system.md](references/visual-system.md) | measured values and ratios: spacing, type, colour roles, contrast, icons, layout, light and dark |
| [references/components.md](references/components.md) | anatomy of every recurring component, desktop and mobile |
| [references/anti-patterns.md](references/anti-patterns.md) | what typically goes wrong, why it hurts the user, and the fix |
| [references/project-profile.md](references/project-profile.md) | template that maps a project's tokens and roles onto this skill |
| [scripts/contrast.py](scripts/contrast.py) | WCAG contrast for colour pairs, with alpha and gradient stops |

## Workflow

### Step 0: project profile (once per project)

Before judging or building anything, fill in [references/project-profile.md](references/project-profile.md)
from the project's CSS, Tailwind config or design tokens: map every token onto a role
(surfaces, text levels, border, accent, semantic colours, primary button), run
`scripts/contrast.py` on every text and surface pair, and record the gaps. Store the profile in
the project (for example `docs/design-profile.md`), never in this skill.

- **Quick task** (one view, one fix): fill only sections 1 and 3 of the profile.
- **No tokens yet** (new design system): take the defaults from visual-system.md, record them
  as the profile, and build the tokens from it.

### Step 1: role card

For every role that sees the view, four lines. Nothing gets built or judged without them.

| Field | Question |
|---|---|
| **Question** | What does the person want to know when they open this view? |
| **Next action** | What should they have done when they leave? |
| **Blocker** | What stops them right now (missing data, waiting on someone, no permission)? |
| **Rhythm and device** | How often, how long, on what device? |

Consequences: the primary action is the next action, or resolving the blocker if there is one.
The first screen answers the question. Rhythm sets density: daily and long means dense tables
and keyboard use; rare and short means guided and mobile first.

### Step 2a: review and redesign (existing screens)

1. Inventory every view per role, desktop and mobile, with the states actually seen.
2. Check each view against the hard rules below and [references/anti-patterns.md](references/anti-patterns.md).
   Write each finding as: rule, where, what the person experiences (in their words), fix.
3. Fix causes before symptoms: shared shell, tokens, button, status pill and table first, then
   single pages.
4. Write a redesign spec per view: layout sketch, what moves where, primary action per state,
   mobile variant. Use the anatomies in [references/components.md](references/components.md).
5. Pre-flight against the spec.

### Step 2b: build a new view

Role card, shell, components from components.md, values from visual-system.md mapped through
the project profile, then pre-flight with real states (empty, partial, full, loading, error,
no permission) and realistic data including one extra long value.

## Hard rules

Every rule can be checked on a screenshot or in code. A broken rule is a finding, not taste.
Numbers are defaults from the references; the project profile may move them within the stated
range, never outside it.

### Shell and placement (values: visual-system.md sections 1 and 6)

1. **One shell for every page:** header (title left, one primary action right on the title row),
   one line of subtext, a fixed gap of 24 to 40, then content in cards. Same gutter, same header
   gap, same card padding, same content width on every page. Built once as a component.
2. **One left edge.** Title, subtext, toolbar, cards and table start on the same x; the primary
   button's right edge equals the content's right edge.
3. **Two content widths at most:** full width for lists and tables, one readable max width for
   forms and text. Never both in one column.
4. **The title is the navigation label** and the breadcrumb's current item; it may carry a
   count ("Open jobs 13", "Bookings today 8"). States and greetings go into the subtext or the
   first card. Active navigation is shown with at least two signals (text level plus icon or
   marker).
5. **Toolbar inside the card it controls:** tabs or filter chips left, icon tools right (sort,
   filter, group, search, view), all controls one height.
6. **Navigation is grouped**, each item with an icon, groups under small labels. Account,
   settings, language and help live in one account area at the bottom of the sidebar. Sign out
   is an icon button with tooltip next to the account, or an icon plus label item in its menu,
   never a loose text link. Legal links go into that menu, not into a footer on every app page,
   unless law requires them to stay permanently visible (imprint, cancellation button).

### Action (values: components.md)

7. **Exactly one solid primary button per view.** Other cards use outline buttons or links.
   Exception: peer cards side by side (plans, options), where only the recommended one is
   solid. Alternatives next to a primary are outline, exits are text links.
8. **The primary action follows the state.** When a blocker exists, the primary action resolves
   it. When the state changes, the action changes in the same place.
9. **One primary button style across the product.** Achromatic: near black on light, raised
   neutral on dark. Never the accent, never a gradient. Same label means same component.
10. **Buttons name the outcome** as verb plus object ("Save changes", "Invite member",
    "Confirm appointment"), never "Submit", "OK" or "Here".
11. **The action sits right after the value it commits to** (price, summary, last field), never
    pinned to a card's bottom with empty space above it.
12. **Row actions:** at most one inline action per row; the rest in a trailing overflow menu and
    in the detail view. Destructive actions are never inline and never in the status cell.
    Reversible actions run at once and offer undo in a toast; irreversible ones confirm with
    the object and the consequence named.
13. **Icon-only buttons only for known tools and meta actions** (sort, filter, search, view,
    close, copy, more, sign out), always with an accessible name and tooltip. Creating,
    sharing, inviting and paying are always labelled.
14. **Nothing covers content.** Sticky bars reserve their height; no floating button sits over
    a control.

### Information (values: components.md)

15. **Each fact once per screen.** One full statement where the decision happens, at most one
    compact pointer elsewhere (a count, a dot).
16. **Subtext states scope, not process:** one line ("All locations, last 30 days"). How a
    feature works goes into the dialog or popover of the action it explains.
17. **No metric on its own.** A number has a label, a period or comparison, and leads to the
    filtered list behind it. A metric must belong to the page it sits on. If it counts the same
    thing as a filter, it becomes the filter's count.
18. **A field has one meaning.** Missing values say so in muted text ("not set"), never blank,
    never a lone dash, never another value moved into the slot.
19. **Columns earn their place.** A column that shows the same value in every row is hidden
    or shows only exceptions. One value per cell; secondary values go to the detail view.
20. **Implementation details stay out of lists** (slugs, database IDs, enum names). They go to
    the detail view with a copy button if anyone needs them. References people use (invoice,
    booking or order numbers) stay, in mono.
21. **Explain once, not per item.** A sentence repeated in every list item becomes a status pill
    in the item and one explanation in the panel or above the list.

### Type (values: visual-system.md section 2)

22. **At most six sizes per screen.** Page title about 1.85x body, card title 1.15 to 1.3x,
    meta 0.85 to 0.92x, metric number 2 to 2.4x its label. Same size hierarchy comes from
    weight and colour, not new sizes.
23. **Sentence case sans for labels, headers, tabs and buttons.** Spaced uppercase only for
    navigation group labels. Mono only for copyable machine identifiers and code; numbers use
    `tabular-nums` in the sans font.
24. **Minimum sizes:** 12 px for meta (11 px only for uppercase navigation group labels),
    14 px body on mobile, 13 to 14 px body on desktop.
25. **Values never break mid word.** Emails, IDs and URLs truncate with ellipsis and show in
    full on hover and in the detail view.

### Colour and contrast (values: visual-system.md sections 3 and 4)

26. **Colour roles, not colours:** neutrals for the interface, one accent for selection,
    progress, focus and inline links, a semantic set for status, one hue per chart series,
    small categorical dots. The accent may double as the info hue and as chart series 1; no other
    hue is shared between two systems on one screen.
27. **All text at least 4.5:1 on the surface it sits on** (the card, not only the page). Three
    levels that step visibly: primary about 12:1 or more, secondary about 7:1, muted 4.5 to
    5.5:1.
28. **Status is icon plus word plus tone.** Pill text at least 4.5:1 on its tint. Red only for
    something that went wrong; inactive, expired, cancelled and rejected are neutral.
29. **Non text contrast:** input borders and meaningful icons at least 3:1 (3 to 4.5:1 for
    inputs, so empty fields do not shout). Layout hairlines may be about 1.2:1. Every stop of
    any gradient that carries text is checked; better, no gradient behind text.
30. **Brand colour is not decoration.** Not on eyebrows, captions or time windows. When the
    brand colour equals a semantic hue (green and success, red and danger), using it as
    decoration makes captions read as status.

### Icons (values: visual-system.md section 5)

31. **One outline icon family**, stroke 1.5 px at 16 px, placed next to 13 to 14 px text and
    coloured like its text. Filled shapes only for status. In labelled buttons the icon leads.
    Every column header and navigation item may carry a type icon; icons never replace a value
    the person needs to read.

### Spacing and density (values: visual-system.md section 1)

32. **One 4 px based scale** (4, 8, 12, 16, 24, 32, 40, 48, 64), three tiers in use: related
    4 to 8, items 12 to 16, groups 2.5 to 3.5 times the item gap (32 to 56). A label is closer
    to its own field than to the previous one.
33. **One gap per relationship**, the same horizontally and vertically; one card padding per
    product (16 or 24); page gutter 32 to 64 on desktop and 16 on mobile, always larger than
    the card padding.
34. **Dense rows are 2.5 to 3.3 times the body size** (36 to 44 px), single line; rich list rows
    have one main line and one muted meta line. More than six comparable items are a table or
    list, not cards.

### States

35. **Loading is a skeleton in the shape of the page**, shown after about 300 ms, never a
    centred spinner.
36. **Empty states live in the same card** as the content, name the reason (including a
    blocker) and offer one action. No dashed boxes. Empty secondary sections shrink to one line.
    "No results" for a search or filter differs from "no data yet" and offers "Clear filters".
37. **Errors say what happened and what now,** keep the input, and offer retry as a button.
38. **Forms:** every input has a visible label that stays while typing; placeholders show
    format only, never realistic sample data; helper and error text sit 4 to 10 px under their
    field; missing required fields are a warning before submit and an error only after.
    One choice out of more than six options is a select or radio list, not a wall of chips.
    Save state is visible.
39. **Limits are honest:** usage shows used and limit with an indicator; at the limit is a
    warning, not success; "not included" is said in words, not "0 / 0". Feature lists use one
    marker per row, and excluded items say so in text, not only with a dash.

### Mobile

40. **Nothing is clipped.** Below 768 px tables become row lists (line 1 name plus status,
    line 2 the two deciding attributes), records open as full screen sheets with their actions,
    filter chips scroll in one row, metric tiles never stack full width before the content,
    touch targets are at least 44 px, and the primary action stays on the title row.
41. **Between phone and desktop** (about 768 to 1200 px): the sidebar collapses to an icon rail
    or drawer below about 1024, the side panel becomes an overlay, wide tables scroll
    horizontally with a sticky first column and a visible scroll hint.

### Weight

42. **Weight is a budget.** The deciding value and the one action carry the most weight on a
    screen; promotions, upsells and help sit below the task at the lowest weight that still
    passes contrast (visual-system.md section 8).

### Behaviour

43. **Focus and keyboard:** a visible focus ring (accent, at least 3:1, 2 px offset) on every
    interactive element including table rows; Escape closes the topmost layer; views used daily
    get keyboard shortcuts for search and the primary action.
44. **Feedback:** toasts confirm background results and offer undo; they never carry the only
    copy of an error and never cover the primary action.
45. **Lists at scale:** total count visible, sticky table header, pagination or "Load more"
    beyond about 100 rows, filters and sort kept in the URL.

### Time, data and access

46. **Dates and time:** relative time only under seven days, with the absolute value on hover;
    absolute date plus time zone wherever people or resources sit in different zones
    (bookings, shifts, appointments). Formats come from the locale formatter.
47. **Freshness:** data that is synced or cached shows "Updated 5 min ago" and a refresh control.
48. **Access:** hide what a role can never do; disable with a stated reason what another role,
    plan or state unlocks; a no access page says who grants access.

### Language

49. **Text grows.** Allow 30 to 40 percent growth for translations; buttons, tabs and pills never
    have fixed widths; set `lang` and `hyphens: auto` so long compound words break correctly;
    numbers, currency and dates go through the locale formatter.

## Pre-flight

For every view and role. Each "no" is a finding.

1. Does the first screen answer the role card question without scrolling, on desktop and phone?
2. Is there exactly one solid primary button, and is it the next action or the blocker fix?
3. Does the page use the shared shell with the same edges, widths and gaps as its siblings?
4. In greyscale, can every status still be read (icon and word)?
5. Does any fact appear more than twice, or any sentence repeat per item?
6. Does any column show the same value in every row?
7. Do all text levels pass on the surface they sit on (`scripts/contrast.py`)?
8. Are there more than six type sizes, any uppercase outside nav group labels, any mono
   outside identifiers and references?
9. Are empty, loading, error and no permission states built and seen with realistic data?
10. At 360 px: nothing clipped, nothing covered, no table squeezed?
11. Keyboard: everything reachable in order, focus visible, Escape closes layers?
12. At 1024 px: sidebar, panel and tables still usable?
13. With text 40 percent longer (translation, long names): nothing truncates that matters?

## Output of a review

1. Project profile (or the gaps found in the existing one).
2. Role cards.
3. Findings table, shared shell findings first.
4. Redesign spec per view, desktop and mobile.
5. Order of implementation: tokens, shell, shared components, pages.

## Not in scope

Marketing pages, heroes, landing pages, brand development and detailed chart design. When a
chart is needed, this skill only decides whether it earns its place and keeps it to one hue
per series.
