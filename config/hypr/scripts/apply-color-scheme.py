#!/usr/bin/env python3
"""Apply a KDE color scheme (.colors file) into ~/.config/kdeglobals.

Mimics what plasma-apply-colorscheme does, without requiring plasma-workspace.
Usage: apply-color-scheme.py BreezeLight|BreezeDark
"""
import configparser
import sys
from pathlib import Path

SCHEME_DIR = Path("/usr/share/color-schemes")
KDEGLOBALS = Path.home() / ".config" / "kdeglobals"


def load(path):
    cp = configparser.ConfigParser(strict=False, interpolation=None)
    cp.optionxform = str  # preserve key case
    if path.exists():
        cp.read(path)
    return cp


def main():
    if len(sys.argv) != 2:
        sys.exit(f"usage: {sys.argv[0]} <SchemeName>")

    scheme_name = sys.argv[1]
    scheme_file = SCHEME_DIR / f"{scheme_name}.colors"
    if not scheme_file.exists():
        sys.exit(f"scheme not found: {scheme_file}")

    scheme = load(scheme_file)
    globals_cfg = load(KDEGLOBALS)

    for section in scheme.sections():
        if section not in globals_cfg:
            globals_cfg.add_section(section)
        for key, value in scheme.items(section):
            # Skip localized Name[xx] translations, keep plain Name/ColorScheme
            if key.startswith("Name[") and key != "Name":
                continue
            globals_cfg.set(section, key, value)

    KDEGLOBALS.parent.mkdir(parents=True, exist_ok=True)
    with open(KDEGLOBALS, "w") as f:
        globals_cfg.write(f, space_around_delimiters=False)


if __name__ == "__main__":
    main()
