# dotfiles

![Platform](https://img.shields.io/badge/platform-macOS-lightgrey)
![Neovim](https://img.shields.io/badge/Neovim-0.9%2B-57A143?logo=neovim)
![License](https://img.shields.io/badge/license-MIT-blue)

Configuraciones personales para un entorno de desarrollo macOS orientado a la terminal. El objetivo es un setup minimalista, rápido y coherente visualmente usando [Catppuccin](https://github.com/catppuccin/catppuccin) como tema unificado en todas las herramientas.

## Stack

| Herramienta | Rol | Nota |
|-------------|-----|------|
| [Neovim](https://neovim.io) | Editor principal | Lazy.nvim, LSP, Copilot |
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal | GPU-accelerated, splits nativos |
| [Aerospace](https://github.com/nikitabobko/AeroSpace) | Window manager | i3-like para macOS |
| [Zed](https://zed.dev) | Editor alternativo | Vim mode, carga rápida |
| Catppuccin | Tema | Latte (light) / Mocha (dark), dinámico |

---

## Preview

> Añade aquí capturas de pantalla de tu setup.
> Sugerencia: `CMD+Shift+4` para capturar región, luego arrastra los archivos a esta sección.

---

## Requisitos

### Homebrew

```bash
brew install neovim git
brew install --cask wezterm aerospace zed
```

### Fuente

CommitMono Nerd Font (requerida por Neovim y WezTerm para iconos):

```bash
brew install --cask font-commit-mono-nerd-font
```

### Opcional

```bash
# GitHub Copilot (requiere cuenta activa)
# Se activa automáticamente al abrir Neovim la primera vez
# y ejecutar :Copilot setup
```

---

## Instalación

### 1. Clonar el repositorio

```bash
git clone git@github.com:djego/dotfiles.git ~/dotfiles
```

### 2. Crear symlinks

```bash
# Asegúrate de que ~/.config existe
mkdir -p ~/.config

# Neovim
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim

# WezTerm
ln -sf ~/dotfiles/.config/wezterm ~/.config/wezterm

# Aerospace
ln -sf ~/dotfiles/.config/aerospace ~/.config/aerospace

# Zed
ln -sf ~/dotfiles/.config/zed ~/.config/zed
```

### 3. Inicializar Neovim

Abre Neovim y espera a que [lazy.nvim](https://github.com/folke/lazy.nvim) instale todos los plugins automáticamente:

```bash
nvim
```

Los LSP servers (TypeScript, Lua) se instalan automáticamente via [Mason](https://github.com/williamboman/mason.nvim) en el primer arranque.

### 4. Arrancar Aerospace

Abre Aerospace desde Spotlight o Applications. En el primer arranque pedirá permisos de accesibilidad en **System Settings → Privacy & Security → Accessibility**.

---

## Neovim

### Highlights

- **LSP** completo para TypeScript y Lua via Mason
- **Telescope** — fuzzy finder para archivos, búsqueda en texto y referencias LSP
- **Treesitter** — sintaxis para Lua, TypeScript, JavaScript, Rust, JSON, Markdown
- **GitHub Copilot** — sugerencias inline (`<C-j>` para aceptar)
- **Gitsigns** — hunks, blame, diff y staging sin salir del editor
- **Catppuccin** — tema con fondo transparente y blur, adapta al modo del sistema

### Plugins

| Categoría | Plugin | Función |
|-----------|--------|---------|
| **UI** | catppuccin/nvim | Tema principal |
| **UI** | nvim-lualine/lualine.nvim | Status line |
| **UI** | akinsho/bufferline.nvim | Pestañas de buffers |
| **UI** | nvim-tree/nvim-tree.lua | Explorador de archivos |
| **UI** | nvim-web-devicons | Iconos de archivos |
| **Navegación** | nvim-telescope/telescope.nvim | Fuzzy finder |
| **Sintaxis** | nvim-treesitter/nvim-treesitter | Parser de sintaxis |
| **Edición** | echasnovski/mini.comment | Comentar con `gcc` / `gc` |
| **Edición** | echasnovski/mini.pairs | Auto-cierre de brackets |
| **Edición** | echasnovski/mini.surround | Manipular surroundings |
| **Edición** | echasnovski/mini.indentscope | Guías de indentación |
| **Edición** | github/copilot.vim | Sugerencias Copilot |
| **LSP** | williamboman/mason.nvim | Package manager LSP |
| **LSP** | williamboman/mason-lspconfig.nvim | Integración LSP |
| **Git** | lewis6991/gitsigns.nvim | Git hunks en el margen |

### Keymaps

El líder es `<Space>`.

#### General

| Modo | Hotkey | Acción |
|------|--------|--------|
| Normal | `<leader>s` | Guardar archivo |
| Normal | `<leader>q` | Cerrar |
| Normal | `<leader>h` | Limpiar highlight de búsqueda |
| Normal | `<leader>a` | Seleccionar todo |
| Insert | `jk` | Volver a modo normal |

#### Splits y buffers

| Modo | Hotkey | Acción |
|------|--------|--------|
| Normal | `<leader>v` | Split vertical |
| Normal | `<leader>x` | Split horizontal |
| Normal | `<leader>c` | Cerrar split |
| Normal | `<C-h/j/k/l>` | Navegar entre splits |
| Normal | `<S-l>` | Siguiente buffer |
| Normal | `<S-h>` | Buffer anterior |
| Normal | `<leader>bd` | Cerrar buffer |

#### Edición (Visual)

| Modo | Hotkey | Acción |
|------|--------|--------|
| Visual | `J` / `K` | Mover líneas arriba/abajo |
| Visual | `<` / `>` | Indentar manteniendo selección |
| Visual | `p` | Pegar sin sobreescribir el registro |
| Normal | `<C-d>` / `<C-u>` | Scroll centrado |
| Normal | `n` / `N` | Buscar con resultado centrado |

#### LSP

| Modo | Hotkey | Acción |
|------|--------|--------|
| Normal | `K` | Hover / documentación |
| Normal | `<leader>rn` | Rename symbol |
| Normal | `<leader>ca` | Code action |
| Normal | `<leader>f` | Format (LSP) |
| Normal | `[d` / `]d` | Diagnóstico anterior/siguiente |
| Normal | `<leader>d` | Abrir diagnóstico flotante |

#### Git (Gitsigns)

| Modo | Hotkey | Acción |
|------|--------|--------|
| Normal | `]c` / `[c` | Siguiente/anterior hunk |
| Normal | `<leader>gp` | Preview hunk |
| Normal | `<leader>gd` | Diff del archivo |
| Normal | `<leader>gb` | Blame de línea |
| Normal | `<leader>gB` | Blame del archivo |
| Normal | `<leader>gs` | Stage hunk |
| Normal | `<leader>gr` | Reset hunk |

#### Telescope

| Modo | Hotkey | Acción |
|------|--------|--------|
| Normal | `<leader>ff` | Find files |
| Normal | `<leader>fg` | Live grep |
| Normal | `gd` | Go to definition (LSP) |
| Normal | `gr` | References (LSP) |
| Normal | `gi` | Implementations (LSP) |

### LSP

Servidores activos por defecto:

| Server | Lenguaje |
|--------|---------|
| `ts_ls` | TypeScript / JavaScript |
| `lua_ls` | Lua |

Para añadir más servidores edita `.config/nvim/lua/plugins/init.lua` en la sección `ensure_installed` de `mason-lspconfig` y añade el nombre del server (e.g. `"pyright"`, `"rust_analyzer"`).

---

## WezTerm

### Configuración visual

| Setting | Valor |
|---------|-------|
| Font | CommitMono Nerd Font Mono 14 |
| Tema oscuro | Catppuccin Mocha |
| Tema claro | Catppuccin Latte |
| Tema | Dinámico (sigue la apariencia del sistema) |
| Opacidad | 0.95 |
| Blur (macOS) | 10 |
| FPS máximo | 120 |
| Scrollback | 10,000 líneas |

### Keybindings

| Hotkey | Acción |
|--------|--------|
| `CMD+Shift+d` | Split vertical |
| `CMD+d` | Split horizontal |
| `CMD+w` | Cerrar pane |
| `CMD+Shift+Enter` | Fullscreen del pane actual |
| `CMD+Shift+h` | Foco al pane izquierdo |
| `CMD+Shift+j` | Foco al pane inferior |
| `CMD+Shift+k` | Foco al pane superior |
| `CMD+Shift+l` | Foco al pane derecho |

### Hyperlinks personalizados

Incluye una regla para convertir referencias cortas de GitHub en enlaces clicables:

```
gh:owner/repo#123  →  https://github.com/owner/repo/issues/123
```

---

## Aerospace

Tiling window manager al estilo i3 para macOS. Las ventanas se organizan automáticamente sin necesidad de moverlas manualmente.

### Workspaces

26 workspaces disponibles (A–Z). Cada uno es independiente y puede vivir en cualquier monitor.

### Layout por defecto

- **Tiles** (ventanas en mosaico)
- Orientación automática: horizontal si el monitor es ancho, vertical si es alto
- Gaps internos: 5px | Gaps externos: 5px

### Keybindings principales

| Hotkey | Acción |
|--------|--------|
| `Alt+h/j/k/l` | Mover foco (izquierda/abajo/arriba/derecha) |
| `Alt+Shift+h/j/k/l` | Mover ventana en la dirección |
| `Alt+a…z` | Ir al workspace A–Z |
| `Alt+Shift+a…z` | Mover ventana al workspace A–Z |
| `Alt+/` | Toggle: tiles ↔ vertical |
| `Alt+,` | Toggle: accordion ↔ vertical |
| `Alt+Shift+Enter` | Fullscreen de la ventana |
| `Alt+Tab` | Alternar entre los 2 últimos workspaces |
| `Alt+Shift+Tab` | Mover workspace al siguiente monitor |
| `Alt+-` | Reducir tamaño (smart -50px) |
| `Alt+=` | Aumentar tamaño (smart +50px) |
| `Alt+r` | Entrar modo **resize** |
| `Alt+Shift+;` | Entrar modo **service** |

### Modo resize

Activado con `Alt+r`. Dentro del modo:

| Hotkey | Acción |
|--------|--------|
| `h/j/k/l` | Resize smart en la dirección |
| `Esc` | Salir del modo |

### Modo service

Activado con `Alt+Shift+;`. Permite operaciones menos frecuentes:

| Hotkey | Acción |
|--------|--------|
| `r` | Recargar configuración de Aerospace |
| `f` | Aplanar el workspace (flatten) |
| `Backspace` | Toggle floating / tiling |
| `Up/Down/Left/Right` | Unir ventana a la ventana adyacente |
| `Volume up/down` | Control de volumen |

---

## Zed

Editor alternativo con carga rápida. Útil para edición rápida de archivos o como fallback.

```json
{
  "vim_mode": true,
  "base_keymap": "Cursor",
  "ui_font_size": 16,
  "buffer_font_size": 15,
  "theme": {
    "mode": "system",
    "light": "Catppuccin Latte (Blur)",
    "dark": "Catppuccin Espresso (Blur)"
  },
  "icon_theme": "Catppuccin Mocha"
}
```

---

## Estructura del repositorio

```
dotfiles/
└── .config/
    ├── aerospace/
    │   └── aerospace.toml          # Window manager config
    ├── nvim/
    │   ├── init.lua                # Opciones, autocmds, colorscheme
    │   ├── lazy-lock.json          # Lockfile de plugins
    │   └── lua/
    │       ├── keymaps.lua         # Keybindings globales
    │       └── plugins/
    │           ├── init.lua        # LSP, Telescope, Treesitter, NvimTree
    │           ├── copilot.lua     # GitHub Copilot
    │           ├── git.lua         # Gitsigns
    │           ├── mini.lua        # Mini plugins (comment, pairs, surround)
    │           └── ui.lua          # Catppuccin, Lualine, Bufferline
    ├── wezterm/
    │   └── wezterm.lua             # Terminal config
    └── zed/
        └── settings.json           # Zed config
```

---

## Personalización

### Cambiar el tema

El tema Catppuccin es consistente en todas las herramientas. Para cambiar el flavour (latte, frappe, macchiato, mocha) edita:

- **Neovim**: `.config/nvim/lua/plugins/ui.lua` → `flavour`
- **WezTerm**: `.config/wezterm/wezterm.lua` → `color_scheme`
- **Zed**: `.config/zed/settings.json` → `theme.light` / `theme.dark`

### Añadir LSP servers

En `.config/nvim/lua/plugins/init.lua`, dentro de `mason-lspconfig`:

```lua
ensure_installed = {
  "ts_ls",
  "lua_ls",
  "pyright",        -- Python
  "rust_analyzer",  -- Rust
},
```

### Ajustar gaps de Aerospace

En `.config/aerospace/aerospace.toml`:

```toml
[gaps]
inner.horizontal = 5
inner.vertical   = 5
outer.top        = 5
outer.bottom     = 5
outer.left       = 5
outer.right      = 5
```

---

## Licencia

MIT
