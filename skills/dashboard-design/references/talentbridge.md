# Project profile: TalentBridge

MyTalentBridge, a brand of BMP Agency GmbH. Job portal and staffing service (hospitality,
events, logistics) with three audiences: applicants (logged-in area with Übersicht, Jobportal, Bewerbungen,
Termine, Profil), clients booking staff, and the back office (`/backoffice`).

Tokens below are taken from the compiled CSS of the staging deployment
(`talentbridgestaging.vercel.app`, October 2026). Stack: Next.js, Tailwind v4, shadcn/ui
variables. When the repository is available, its `globals.css` is the source of truth and
this file is updated from it.

## Type

| Token | Value | Use |
|---|---|---|
| `--font-sans` | Manrope | everything |
| `--font-mono` | JetBrains Mono | IDs, codes, eyebrows, numbers in tables if not tabular |

Sizes are the Tailwind defaults (`text-xs` 12 px to `text-5xl` 48 px). Weights 400 to 800.

## Colour

Brand:

| Token | Value |
|---|---|
| `--brand-50` | `#f1fbf4` |
| `--brand-100` | `#dff4e4` |
| `--brand-300` | `#8ae075` |
| `--brand-500` | `#0b995a` |
| `--brand-600` | `#0b6f42` (`--primary`) |
| `--brand-700` | `#06301c` |
| `--brand-gradient` | `linear-gradient(180deg, #6ad359, #0b995a)` |

Neutral:

| Token | Value |
|---|---|
| `--neutral-0` | `#fff` (background, card) |
| `--neutral-50` | `#f6f7f5` (muted, app background) |
| `--neutral-100` | `#eceeea` |
| `--neutral-200` | `#dcdfda` |
| `--neutral-400` | `#9aa5a0` |
| `--neutral-500` | `#8b9691` |
| `--neutral-600` | `#5b6863` (muted text) |
| `--neutral-700` | `#3d4a44` |
| `--neutral-900` | `#0f1512` (foreground, dark sidebar) |
| `--border` | `#0f15121a` |
| `--input` | `#0f151229` |

Status:

| Tone | Text | Background | Line |
|---|---|---|---|
| ok | `--status-ok` = brand 600 | `#6ad35929` | `#0b995a40` |
| warn | `#8b6b1f` | `#d6a62c29` | `#d6a62c66` |
| info | `#1f5b8b` | `#2c82d624` | missing |
| danger | `#8b3b3b` | `#be46461f` | missing |
| offen | `#f2a33a` | missing | missing |

Radius: `--radius` 10 px, `--radius-md` 8 px, `--radius-sm` 6 px.

## Token gaps to close

1. **`--status-offen` has no background and line**, and `#f2a33a` as text fails contrast on
   white. Either map "offen" to `warn` or add `--status-offen-text` (dark), `-bg`, `-line`.
2. **`--status-info-line` and `--status-danger-line` are missing**; pills cannot be built
   uniformly.
3. **`--chart-1` to `--chart-5` are the shadcn greys.** Set `--chart-1` to brand 500 and
   derive the rest from the `dataviz` skill, or charts will ignore the brand.
4. **`--sidebar-*` are shadcn defaults** (light grey) while the app sidebar is dark
   `neutral-900`. Either the tokens are unused (remove) or the sidebar is hard coded (fix).
5. **No decided primary button.** See finding 1 below.

## Findings from the staging applicant area

Reviewed on screenshots of Übersicht, Jobportal, Meine Bewerbungen, Termine, Profil &
Lebenslauf, logged in as an applicant with a 29 % profile. Back office not yet reviewed.

What already works and stays:

- Dark sidebar, light neutral work surface, white cards: calm and clearly zoned.
- Readiness checklist with "4 fehlen" per section and one action per row.
- Section badges "4 FEHLEN" in warn tone, missing required fields tinted warn before submit
  (rule 15 done right).
- Empty state on Meine Bewerbungen with reason and "Zum Jobportal" action.
- Title as data on the job portal ("13 offene Stellen").

| # | Rule | Where | What the user experiences | Fix |
|---|---|---|---|---|
| 1 | 3 | Übersicht, Termine, Profil | "Termin anfragen" is black on Termine and a green gradient on the Übersicht card; "Speichern" is green, "Jobs durchsuchen" black. The user cannot learn what the main button looks like. | Decide one primary: brand 600 solid. Black only as secondary dark surfaces, never for buttons. No gradient on buttons. |
| 2 | 2 | Übersicht | Primary action is "Jobs durchsuchen" although the user cannot apply yet. They browse, pick a job, and hit a wall. | Primary "Profil vervollständigen" while incomplete; switch to "Jobs durchsuchen" when complete. |
| 3 | 6 | Übersicht, all pages | Profile progress appears three times: sidebar card (29 %, 10 Pflichtangaben), checklist header (10 Angaben), orange dot in navigation. | Checklist is the source. Sidebar card becomes one compact line linking to it; keep or drop the dot, not both. |
| 4 | 27 | Übersicht | "Hallo weqwqe, Schön, dass du da bist." takes the first line and says nothing. | "Noch 10 Angaben bis zur ersten Bewerbung" as title, name in the sidebar is enough. |
| 5 | 22, 20 | Übersicht | "Meine Bewerbungen" and "Für dich empfohlen" are two full empty cards. "Zurzeit keine passenden Vorschläge" does not say that the incomplete profile is the reason. | While blocked: one line naming the blocker. Show the sections once there is content. |
| 6 | 1, 14 | Übersicht | The dark counselling card with its own green button competes with the checklist and the top button. Three emphasis points. | Counselling as a secondary row or a quiet card without a filled button. |
| 7 | 7 | Jobportal | "Stelle 1" shows "ab sofort" in the slot where all others show the wage. | Fixed slot meaning; "Lohn auf Anfrage" when missing. Also realistic seed data. |
| 8 | 8, 17 | Jobportal | Location and employment type are small green mono capitals, wage is muted grey; the two things applicants decide on are the weakest text. Two column cards with lots of air make 13+ jobs slow to scan. | Job row pattern from patterns.md: title, wage and type at body size, location with distance, state relative to the person. |
| 9 | 2, 22 | Jobportal, Meine Bewerbungen | Nothing tells the applicant they cannot apply yet. "Zum Jobportal" sends them to jobs they cannot apply to. | Hint on the job portal while blocked, and the empty state names the blocker with "Profil vervollständigen". |
| 10 | 26, 6 | Termine | Four line marketing paragraph, the price stated three times (paragraph, note, overview card), an accordion of topics from the public page. | One sentence plus price once next to the button. Topics go behind "Mehr erfahren" or into the request form as a topic select. |
| 11 | 22 | Termine | "Noch keine Anfrage gestellt." without action next to it. | Add "Termin anfragen" in the empty state or name what happens after requesting. |
| 12 | 5 | Profil | The floating green "Speichern" covers the "Hochladen" action of Profilfoto. | Sticky save bar with reserved bottom padding and visible save state. |
| 13 | 7 | Profil | "optional" only as placeholder on Geburtsname and Telefon disappears on typing. | "optional" in the label. |
| 14 | patterns: form | Profil | Twelve status chips for a single choice wrap over three lines. | Select or radio list for more than six options. |
| 15 | 2 (layout) | Termine | Content width changes within the page (divider and accordion narrower than the header). | One content width per page. |

## Open

- Back office screens: need screenshots or repository access. Review with the back office role
  card from patterns.md.
- Client booking area: not seen yet.
- Mobile: all findings above are desktop; check each view at 360 px.
