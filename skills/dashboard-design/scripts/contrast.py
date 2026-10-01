#!/usr/bin/env python3
"""WCAG 2.x contrast for colour pairs.

Usage:
  contrast.py FG BG [--on BASE]
  contrast.py --file pairs.txt [--on BASE]

Colours are hex: #rgb, #rrggbb or #rrggbbaa. A colour with alpha is composited onto the
colour behind it: FG onto BG, and BG onto BASE (default #ffffff).
BASE must be opaque (its alpha is ignored).
BG may be a gradient written as a,b[,c...]; every stop and 8 points per segment are checked and
the worst ratio wins.

pairs.txt holds one pair per line: "label; FG; BG" (lines starting with # are ignored).

Prints the ratio and the levels it reaches: 3 (borders, icons, large text), 4.5 (any text,
hard minimum), 7 (secondary text target), 12 (primary text target).
"""
import argparse
import sys


def parse(hexstr):
    h = hexstr.strip().lstrip("#")
    if len(h) == 3:
        h = "".join(c * 2 for c in h)
    if len(h) not in (6, 8) or any(c not in "0123456789abcdefABCDEF" for c in h):
        raise ValueError(f"not a hex colour: {hexstr}")
    r, g, b = (int(h[i:i + 2], 16) for i in (0, 2, 4))
    a = int(h[6:8], 16) / 255 if len(h) == 8 else 1.0
    return (r, g, b, a)


def over(top, bottom):
    r, g, b, a = top
    br, bg, bb, _ = bottom
    return (r * a + br * (1 - a), g * a + bg * (1 - a), b * a + bb * (1 - a), 1.0)


def lum(c):
    def ch(v):
        v = v / 255
        return v / 12.92 if v <= 0.03928 else ((v + 0.055) / 1.055) ** 2.4
    r, g, b, _ = c
    return 0.2126 * ch(r) + 0.7152 * ch(g) + 0.0722 * ch(b)


def ratio(a, b):
    la, lb = lum(a), lum(b)
    hi, lo = max(la, lb), min(la, lb)
    return (hi + 0.05) / (lo + 0.05)


def stops(bg, base):
    parts = [over(parse(p), base) for p in bg.split(",")]
    if len(parts) == 1:
        return parts
    out = []
    for a, b in zip(parts, parts[1:]):
        for i in range(9):
            f = i / 8
            out.append(tuple(a[j] + (b[j] - a[j]) * f for j in range(3)) + (1.0,))
    return out


def check(fg, bg, base):
    worst = None
    for s in stops(bg, base):
        r = ratio(over(parse(fg), s), s)
        worst = r if worst is None else min(worst, r)
    return worst


def verdict(r):
    levels = [(12, "primary target"), (7, "secondary target"), (4.5, "text"), (3, "non-text")]
    passed = [name for lim, name in levels if r >= lim]
    return ", ".join(passed) if passed else "fails all"


def main():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("fg", nargs="?")
    p.add_argument("bg", nargs="?")
    p.add_argument("--on", default="#ffffff", help="base colour behind BG (default #ffffff)")
    p.add_argument("--file", help="file with 'label; FG; BG' lines")
    args = p.parse_args()
    try:
        base = parse(args.on)
    except ValueError as e:
        sys.exit(f"--on: {e}")
    rows = []
    if args.file:
        with open(args.file) as f:
            for n, line in enumerate(f, 1):
                line = line.strip()
                if not line or line.startswith("#"):
                    continue
                parts = [x.strip() for x in line.split(";")]
                if len(parts) != 3:
                    sys.exit(f"{args.file}:{n}: expected 'label; FG; BG'")
                rows.append((parts[0], parts[1], parts[2]))
    elif args.fg and args.bg:
        rows.append(("", args.fg, args.bg))
    else:
        p.print_help()
        sys.exit(1)
    for label, fg, bg in rows:
        try:
            r = check(fg, bg, base)
        except ValueError as e:
            sys.exit(f"{label or fg}: {e}")
        name = f"{label}: " if label else ""
        print(f"{name}{fg} on {bg}  {r:.2f}:1  ({verdict(r)})")


if __name__ == "__main__":
    main()
