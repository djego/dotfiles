# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles, reusable across macOS and Arch Linux — declarative configuration for Neovim, WezTerm, Zed, Aerospace (macOS window manager), Hyprland (Linux window manager/compositor), Kitty, gh (GitHub CLI), glow, and rtk. There is no build, lint, or test tooling; changes are validated by symlinking into `~/.config` and running the tool (`nvim`, `wezterm`, reloading Aerospace/Hyprland, etc.).

## Applying changes

Configs live under `config/<tool>/` in this repo, one Stow package per tool. `./install.sh` (GNU Stow under the hood) symlinks each package to `~/.config/<tool>/` — see README.md "Instalación" for OS-specific package sets and the manual `stow` invocation. Editing a file here immediately affects the live config once the symlink exists — there is no build step.

- **Neovim**: relaunch `nvim`, or `:source %` / restart for `init.lua`/plugin-spec changes. Plugin changes go through lazy.nvim, which lazily installs/loads on the next launch.
- **Aerospace** (macOS): reload via the in-app service mode (`Alt+Shift+;` then `r`), not a process restart.
- **Hyprland** (Linux): reload via `hyprctl reload`, or restart the compositor for changes that need a full re-init (monitor layout, etc.).
- **WezTerm**: config is hot-reloaded automatically on save.
- **Zed**: settings apply on save.

## Architecture

### Neovim (`config/nvim/`)

- `init.lua` — entry point. Sets `mapleader`, bootstraps `lazy.nvim` (cloning it on first run), calls `require("lazy").setup("plugins")`, then sets core `vim.opt` options, diagnostic config, LSP hover/signature borders, and autocmds (cursorline-on-focus, relativenumber toggle on insert, `LspAttach` keymaps). Keymaps set here (in the `LspAttach` autocmd) are LSP-specific and buffer-local; general keymaps live in `lua/keymaps.lua`.
- `lua/keymaps.lua` — global (non-LSP) keybindings, exposed via `require("keymaps").setup()`.
- `lua/plugins/*.lua` — each file returns a lazy.nvim plugin spec list; `require("lazy").setup("plugins")` auto-loads every module in this directory as one merged spec table. Split by concern:
  - `init.lua` — nvim-tree, telescope, treesitter, lualine, catppuccin, mason + mason-lspconfig (LSP server install/enable).
  - `git.lua` — gitsigns.
  - `mini.lua` — mini.comment / mini.pairs / mini.surround / mini.indentscope.
  - `ui.lua` — bufferline and other UI chrome (catppuccin flavour is also configured here).
  - `copilot.lua` — GitHub Copilot.
- To add an LSP server: add its name to `ensure_installed` in `mason-lspconfig.setup()` (`lua/plugins/init.lua`) and add a corresponding `vim.lsp.config(...)` + include it in the trailing `vim.lsp.enable({...})` call — servers aren't picked up automatically just from `ensure_installed`.
- `lazy-lock.json` is the plugin version lockfile; don't hand-edit it.

### WezTerm (`config/wezterm/wezterm.lua`)

Single-file config: font, Catppuccin theme (dynamic light/dark via system appearance), opacity/blur, keybindings for pane splits/navigation, and a custom hyperlink rule that turns `gh:owner/repo#123` into a clickable GitHub issue URL.

### Aerospace (`config/aerospace/aerospace.toml`) — macOS only

i3-style tiling window manager config: 26 workspaces (A–Z), gap settings, and keybinding modes — default, `resize` (`Alt+r`), and `service` (`Alt+Shift+;`) — each defined as its own `[mode.<name>.binding]` table.

### Hyprland (`config/hypr/`) — Linux only

- `hyprland.lua` — main config, using Hyprland's experimental Lua config format (`hl.monitor(...)`, `hl.on(...)`, etc. instead of the classic `.conf` keyword syntax). Monitor names/modes in the `MONITORS` section are hardcoded to the machine this was imported from (check `hyprctl monitors all` before reusing on a new device) — generalize before extending to other hosts.
- `hypridle.conf` / `hyprlock.conf` — idle daemon and lockscreen (still classic `.conf` syntax, separate binaries from Hyprland core).
- `hyprpaper.conf.unused` — wallpaper daemon config, currently unused (kept for reference).
- `scripts/` — helper scripts invoked from keybinds/autostart: `apply-color-scheme.py`, `clipboard-menu.sh`, `keep-wallpaper.sh`, `powermenu.sh`.

### Zed (`config/zed/settings.json`)

Single JSON settings file: vim mode, Cursor-style keymap, Catppuccin theme/icon theme.

### Kitty (`config/kitty/`)

`kitty.conf` (font, transparency/blur, tab bar, shell integration) `include`s `theme.conf` (Catppuccin Mocha colors) — keep the two split rather than inlining the theme.

### gh — GitHub CLI (`config/gh/config.yml`)

CLI preferences only (git protocol, aliases, pager). **`~/.config/gh/hosts.yml` (the OAuth token) is deliberately not in this repo or symlinked** — it's a credential, generated per-machine via `gh auth login`, never copy it in here.

### glow (`config/glow/glow.yml`)

Markdown renderer preferences (style, width, pager off).

### rtk (`config/rtk/`)

`config.toml` (tracking/display/filter/telemetry settings) and `filters.toml` (user-global output filters, see comments in-file for the project-local override convention).

## Cross-tool conventions

- **Catppuccin everywhere**: Latte (light) / Mocha (dark) or Espresso for Zed, switching with system appearance. When changing the flavour, update it consistently: `config/nvim/lua/plugins/init.lua` (or `ui.lua`) `flavour`/`background`, `config/wezterm/wezterm.lua` `color_scheme`, `config/zed/settings.json` `theme.light`/`theme.dark`, and `config/kitty/theme.conf`.
- **Leader/prefix consistency**: Neovim leader is `<Space>`; WezTerm/Aerospace/Hyprland use modifier-based bindings (`CMD+...`, `Alt+...` respectively) documented in full in README.md — check there before adding a new binding to avoid collisions.
- **Platform scope**: Neovim, WezTerm, and Zed are cross-platform (macOS + Linux). Aerospace is macOS-only; Hyprland and its `scripts/` are Linux-only. WezTerm's blur setting and Aerospace's CMD-based bindings assume macOS.
