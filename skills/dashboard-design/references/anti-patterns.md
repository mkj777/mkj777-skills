# Anti-patterns

What dashboards built without rules typically look like, why it hurts the person using them,
and the fix. Each entry names the hard rule it breaks. Collected from audits of production
dashboards and from flaws in otherwise good references.

Use this list in a review: scan every screen for each entry, write the finding in the user's
words.

## Shell and navigation

| # | Anti-pattern | What the person experiences | Fix | Rule |
|---|---|---|---|---|
| 1 | Gutter, header gap, card padding or sidebar width differ between pages | "The page jumps when I switch." | One shell component with fixed tokens | 1, 33 |
| 2 | Card or column widths change between pages or inside one page | "The right edge moves while I scroll." | Two widths: full for lists, one max for forms | 3 |
| 3 | Primary button at a different height on every page (on the title, on a paragraph, floating) | "I search for the main button every time." | Title row, right edge | 1, 2 |
| 4 | Filters and search float between header and table, controls in five heights | "The filters look unrelated to the list." | Toolbar inside the card, one control height | 5 |
| 5 | Flat navigation, text only, no groups | "I read every label to find anything." | Groups, small labels, icons | 6 |
| 6 | Nav label, page title and breadcrumb disagree | "Did I land in the right place?" | One name | 4 |
| 7 | Active navigation shown by a fill that is barely visible | "Where am I?" | Two signals | 4 |
| 8 | "Log out" as a small text link next to the name | "Easy to hit by accident, hard to find on purpose." | Icon button with tooltip next to the account, or an item in the account menu | 6, 13 |
| 9 | Marketing footer with legal links on every app page | "'Cancel contract' sits next to my work." | Legal links in the account menu, unless law requires them visible | 6 |

## Action

| # | Anti-pattern | What the person experiences | Fix | Rule |
|---|---|---|---|---|
| 10 | Two primary button styles (black and a brand gradient), the same action in both | "Is the green one something different, like paying?" | One achromatic primary | 9 |
| 11 | A solid primary button in every list item or card | "Four main buttons, so none is the main one." | Action in the detail view or one quiet button; bulk action for selections | 7, 12 |
| 12 | The primary action is the wish, not the blocker fix ("Browse jobs" while the profile cannot apply) | "I picked a job and hit a wall." | Primary action resolves the blocker first | 8 |
| 13 | Two or more stacked buttons in every table row | "Rows are huge and close sits right under duplicate." | Overflow menu, confirm destructive | 12 |
| 14 | A destructive link inside the status cell ("Active" with "Block" under it) | "I nearly blocked someone by tapping the status." | Status alone; action in menu with confirm | 12 |
| 15 | Text says "assign and finish by hand" but there is no assign button | "Where do I do what it tells me?" | The state decides the visible action | 8 |
| 16 | Floating save button over the form | "It covers the upload link." | Sticky bar that reserves space, or save per section | 14 |
| 17 | Action pinned to the card bottom with empty space above | "The card looks finished before the button." | Action right after the deciding value | 11 |
| 18 | Labels like "Submit", "Purchase", "OK" | "What happens when I click?" | Verb plus object, the user's outcome | 10 |

## Information

| # | Anti-pattern | What the person experiences | Fix | Rule |
|---|---|---|---|---|
| 19 | Greeting as title ("Hello Alex, nice to see you") | "The first line tells me nothing." | Title is the page name; the state goes into the subtext or first card ("10 fields left before your first booking") | 4, 16 |
| 20 | Two to four lines of process explanation as subtitle | "I scroll past instructions I read once." | One line of scope; rules in the action's dialog | 16 |
| 21 | Same fact three times (price in paragraph, note and card; progress in widget, checklist and dot) | "Are these different things?" | One source, one pointer | 15 |
| 22 | Identical helper sentence in every list item | "I read every card to see if it says something new." | Status pill per item, explanation once | 21 |
| 23 | Metric tiles that repeat the filter chips below them | "Same numbers twice, only one of them filters." | Counts on the chips | 17 |
| 24 | Metric from another page ("Active subscriptions" on the applications page) | "What am I looking at?" | Metric belongs to its page | 17 |
| 25 | Metric tiles without click target or comparison | "Three is good or bad?" | Label, period, comparison, link | 17 |
| 26 | Columns that show a dash or the same value in every row | "I scan columns for nothing." | Hide, show exceptions only | 19 |
| 27 | Multi value cells (date, time and last login stacked) | "Rows grow, I cannot sort by the second value." | One value per cell | 19 |
| 28 | URL slugs or IDs under every title | "Noise in the column I read most." | Detail view with copy | 20 |
| 29 | Another value moved into an empty slot ("starts now" where the wage should be) | "I compare apples with pears." | "Not set" in muted text | 18 |
| 30 | Count spelled out in every cell ("0 applications" in an "Applicants" column) | "Words where I want numbers." | Number only, zero muted | 19 |
| 31 | Upsell card heavier than the task | "My eye goes to the ad, not to what I need to finish." | Quiet card below the task | 42 |
| 32 | Promotional or help accordion inside a task page | "Marketing in my workspace." | Link to help, keep the page for work | 16 |

## Type

| # | Anti-pattern | What the person experiences | Fix | Rule |
|---|---|---|---|---|
| 33 | Spaced uppercase mono as the label voice (headers, tiles, eyebrows, badges) | "Reads like a terminal, slow to scan." | Sentence case sans, mono for identifiers | 23 |
| 34 | Deciding facts as a tiny eyebrow (location, contract type above the title) | "What I decide on is the hardest text to read." | Body size meta line, chips | 23, 22 |
| 35 | Text at 11 to 12 px on mobile | "I zoom to read." | 14 body, 12 meta minimum | 24 |
| 36 | Emails split mid word, names one word per line | "Unreadable and hard to copy." | Truncate, min widths | 25 |
| 37 | Seven or more type sizes on one screen | "Everything looks a bit different." | Six sizes max | 22 |

## Colour and contrast

| # | Anti-pattern | What the person experiences | Fix | Rule |
|---|---|---|---|---|
| 38 | Brand colour on everything (links, eyebrows, captions, pills, buttons, decoration) | "The brand colour no longer means anything." | Roles; brand as accent only | 26, 30 |
| 39 | Time window in success colour ("next 7 days" in green) | "Looks like good news." | Muted text | 30 |
| 40 | White text on a gradient button | "The save button is the hardest label to read." | Solid achromatic primary | 9, 29 |
| 41 | Warn badge text below 4.5:1 in small caps | "The warning is the faintest text in the section." | Darker text, sans, icon | 28 |
| 42 | Muted grey that passes on the page but fails on the card | "Secondary info is guesswork." | Check on the card | 27 |
| 43 | Red for inactive, expired or rejected | "Something broke?" | Neutral, red for failures only | 28 |
| 44 | Same hue for a status and a category on one screen | "Is 'Software' a status?" | No shared hues | 26 |
| 45 | Status only as colour, seven different pill designs | "I learn each badge separately." | One pill, icon plus word | 28 |
| 46 | Input boundary from a pale fill only, or a pure black outline | "Where is the field?" or "Every empty field shouts." | Neutral border 3 to 4.5:1 | 29 |

## States and forms

| # | Anti-pattern | What the person experiences | Fix | Rule |
|---|---|---|---|---|
| 47 | Dashed empty box, sometimes with, sometimes without action | "Looks like a drop zone, and then what?" | Empty state inside the card with one action | 36 |
| 48 | Empty secondary sections at full card size | "Half the page says nothing." | One line or hide | 36 |
| 49 | Centred spinner | "Is it stuck?" | Skeleton | 35 |
| 50 | Placeholders as labels | "What was this field again?" (after typing or autofill) | Visible small label | 38 |
| 51 | Realistic sample data as placeholder ("Kole Jain") | "Is this already filled in?" | Format hint only | 38 |
| 52 | Helper text next to the button instead of under its field | "I see the rule after I failed." | Under the field | 38 |
| 53 | Wall of chips for one choice out of twelve | "Three lines of options to find mine." | Select or radio list | 38 |
| 54 | "0 / 0" for a feature not in the plan; full usage shown in the success colour | "Is zero of zero fine?" "At the limit is good?" | "Not included"; warn at limit | 39 |
| 55 | Doubled markers in feature lists (check plus bullet), dash alone for excluded | "Which marker matters?" | One marker per row, accessible exclusion | 39 |

## Mobile

| # | Anti-pattern | What the person experiences | Fix | Rule |
|---|---|---|---|---|
| 56 | Desktop table squeezed onto the phone, right columns clipped | "Status and actions are gone." | Row list plus sheet | 40 |
| 57 | Metric tiles stacked full width before the list | "I scroll before I see work." | Chip counts or one compact row | 40 |
| 58 | Filter chips wrapping into two or three rows | "The list starts at the bottom of the screen." | One scrollable row | 40 |

## Process

| # | Anti-pattern | What the person experiences | Fix | Rule |
|---|---|---|---|---|
| 59 | Test data in screens under review ("Test 3009", "asdf", "Item 1") | Layout judged against wrong lengths | Realistic seed data with one extra long value | pre-flight 9 |
| 60 | Fixing single pages before the shell and shared components | The same finding returns on every page | Tokens, shell, components, then pages | workflow |
