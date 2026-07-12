# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal macOS dotfiles — declarative configuration for Neovim, WezTerm, Aerospace (window manager), and Zed. There is no build, lint, or test tooling; changes are validated by symlinking into `~/.config` and running the tool (`nvim`, `wezterm`, reloading Aerospace, etc.).

## Applying changes

Configs live under `.config/<tool>/` in this repo and are symlinked into `~/.config/<tool>/` (see README.md "Instalación" for the exact `ln -sf` commands). Editing a file here immediately affects the live config once the symlink exists — there is no build step.

- **Neovim**: relaunch `nvim`, or `:source %` / restart for `init.lua`/plugin-spec changes. Plugin changes go through lazy.nvim, which lazily installs/loads on the next launch.
- **Aerospace**: reload via the in-app service mode (`Alt+Shift+;` then `r`), not a process restart.
- **WezTerm**: config is hot-reloaded automatically on save.
- **Zed**: settings apply on save.

## Architecture

### Neovim (`.config/nvim/`)

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

### WezTerm (`.config/wezterm/wezterm.lua`)

Single-file config: font, Catppuccin theme (dynamic light/dark via system appearance), opacity/blur, keybindings for pane splits/navigation, and a custom hyperlink rule that turns `gh:owner/repo#123` into a clickable GitHub issue URL.

### Aerospace (`.config/aerospace/aerospace.toml`)

i3-style tiling window manager config: 26 workspaces (A–Z), gap settings, and keybinding modes — default, `resize` (`Alt+r`), and `service` (`Alt+Shift+;`) — each defined as its own `[mode.<name>.binding]` table.

### Zed (`.config/zed/settings.json`)

Single JSON settings file: vim mode, Cursor-style keymap, Catppuccin theme/icon theme.

## Cross-tool conventions

- **Catppuccin everywhere**: Latte (light) / Mocha (dark) or Espresso for Zed, switching with system appearance. When changing the flavour, update it consistently in all three places: `.config/nvim/lua/plugins/init.lua` (or `ui.lua`) `flavour`/`background`, `.config/wezterm/wezterm.lua` `color_scheme`, and `.config/zed/settings.json` `theme.light`/`theme.dark`.
- **Leader/prefix consistency**: Neovim leader is `<Space>`; WezTerm and Aerospace use modifier-based bindings (`CMD+...` and `Alt+...` respectively) documented in full in README.md — check there before adding a new binding to avoid collisions.
- macOS-specific throughout (Aerospace is macOS-only; WezTerm blur/CMD bindings assume macOS).
