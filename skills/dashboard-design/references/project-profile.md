# Project profile (template)

Copy this file into the project (for example `docs/design-profile.md`) and fill it in before
reviewing or building. It maps the project's tokens onto the roles of this skill, records the
decisions the rules leave open, and collects findings. The skill itself stays project agnostic.

## 1. Source

- Where the tokens live (CSS file, Tailwind config, token JSON, component library).
- Fonts (sans, mono) and icon set.
- Themes in use (light, dark, both).

## 2. Roles and areas

| Area | Who uses it | Role card question | Rhythm and device |
|---|---|---|---|
| | | | |

## 3. Token mapping

Fill one row per role. Contrast is measured with `scripts/contrast.py` against the surface the
pair actually appears on.

| Role (visual-system.md section 3) | Project token | Value | Contrast | Verdict |
|---|---|---|---|---|
| Page | | | | |
| Sidebar | | | | |
| Card | | | | |
| Filled control | | | | |
| Hairline border | | | vs card | |
| Input border | | | vs card, needs 3 to 4.5 | |
| Text primary | | | vs card, needs 4.5, target 12 | |
| Text secondary | | | vs card, needs 4.5, target 7 | |
| Text muted | | | vs card, needs 4.5, target 4.5 to 5.5 | |
| Primary button fill and text | | | needs 4.5 | |
| Accent | | | | |
| Focus ring | | | needs 3 | |
| Status ok, text on tint | | | needs 4.5 | |
| Status info, text on tint | | | needs 4.5 | |
| Status warn, text on tint | | | needs 4.5 | |
| Status danger, text on tint | | | needs 4.5 | |
| Neutral status (inactive, expired) | | | needs 4.5 | |
| Chart series 1 | | | | |

Spacing and size tokens:

| Role | Project value | Within range? |
|---|---|---|
| Card padding | | 16 or 24 |
| Page gutter desktop / mobile | | 32 to 64, larger than card padding / 16 |
| Header to first card | | 24 to 40 |
| Item gap / group gap | | 12 to 16 / 32 to 56 |
| Control height | | 32 to 40, one value |
| Table row | | 36 to 44 |
| Sidebar width | | 240 to 248 |
| Radius card / control | | 8 to 12 / 6 to 10 |
| Type sizes in use | | at most six |

## 4. Decisions

Rules that need one project wide answer. Write the answer once and follow it everywhere.

| Decision | Answer |
|---|---|
| Primary button (achromatic per rule 9; name the exact token) | |
| Accent hue and where it appears | |
| Tab style (segmented or underline) | |
| Table or list as the default for each list view | |
| Date, time and number formats | |
| Status vocabulary file in code | |

## 5. Status vocabulary

One map in code from state to label, icon and tone. The normal state may render nothing.

| Domain | State | Label | Icon | Tone |
|---|---|---|---|---|
| | | | | |

## 6. Findings

Shared shell findings first (S1, S2, ...), then per area. Write the experience in the user's
words.

| # | Rule | Where | What the person experiences | Fix |
|---|---|---|---|---|
| | | | | |

## 7. Redesign specs

One block per view: role card reference, desktop sketch, mobile sketch, primary action per
state, components used, states covered.
