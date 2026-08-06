#!/usr/bin/env bash
# Symlinks packages from config/ into ~/.config using GNU Stow.
# Usage:
#   ./install.sh              # link the default packages for this OS
#   ./install.sh nvim hypr    # link only the given packages

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.config"

COMMON_PACKAGES=(nvim wezterm zed rtk gh glow kitty)
MACOS_PACKAGES=(aerospace)
LINUX_PACKAGES=(hypr)

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow is not installed." >&2
  case "$(uname -s)" in
    Darwin) echo "Install it with: brew install stow" >&2 ;;
    Linux)  echo "Install it with: sudo pacman -S stow" >&2 ;;
  esac
  exit 1
fi

if [ "$#" -gt 0 ]; then
  packages=("$@")
else
  case "$(uname -s)" in
    Darwin) packages=("${COMMON_PACKAGES[@]}" "${MACOS_PACKAGES[@]}") ;;
    Linux)  packages=("${COMMON_PACKAGES[@]}" "${LINUX_PACKAGES[@]}") ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac
fi

mkdir -p "$TARGET"

for pkg in "${packages[@]}"; do
  if [ ! -d "$REPO_DIR/config/$pkg" ]; then
    echo "Skipping '$pkg': config/$pkg not found" >&2
    continue
  fi
  echo "Linking $pkg -> $TARGET/$pkg"
  # Target is $TARGET/$pkg (not $TARGET): stow mirrors a package's *contents*
  # directly under the target root, it does not nest them under the package
  # name. Scoping the target per-package is what makes ~/.config/nvim itself
  # hold nvim's files, instead of scattering them into ~/.config/. Stow
  # requires the target dir to pre-exist, so ~/.config/nvim ends up a real
  # directory of per-file symlinks rather than one single symlink - same
  # net effect for the tool, just not tree-folded.
  mkdir -p "$TARGET/$pkg"
  stow -v -d "$REPO_DIR/config" -t "$TARGET/$pkg" "$pkg"
done
