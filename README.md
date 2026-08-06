# dotfiles

![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Arch%20Linux-lightgrey)
![Neovim](https://img.shields.io/badge/Neovim-0.9%2B-57A143?logo=neovim)
![License](https://img.shields.io/badge/license-MIT-blue)

Configuraciones personales para un entorno de desarrollo orientado a la terminal, reutilizable entre macOS y Arch Linux. El objetivo es un setup minimalista, rápido y coherente visualmente usando [Catppuccin](https://github.com/catppuccin/catppuccin) como tema unificado en todas las herramientas. Los symlinks se gestionan con [GNU Stow](https://www.gnu.org/software/stow/).

## Stack

| Herramienta | Rol | Nota | Plataforma |
|-------------|-----|------|------------|
| [Neovim](https://neovim.io) | Editor principal | Lazy.nvim, LSP, Copilot | macOS + Linux |
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal | GPU-accelerated, splits nativos | macOS + Linux |
| [Zed](https://zed.dev) | Editor alternativo | Vim mode, carga rápida | macOS + Linux |
| [Aerospace](https://github.com/nikitabobko/AeroSpace) | Window manager | i3-like para macOS | Solo macOS |
| [Hyprland](https://hyprland.org) | Window manager | Compositor Wayland, config en Lua | Solo Linux |
| [Kitty](https://sw.kovidgoyal.net/kitty/) | Terminal alternativo | GPU-accelerated | macOS + Linux |
| [gh](https://cli.github.com) | GitHub CLI | Auth/tokens NO viven aquí (ver nota abajo) | macOS + Linux |
| [glow](https://github.com/charmbracelet/glow) | Renderizador de Markdown | Preview de `.md` en terminal | macOS + Linux |
| [rtk](https://github.com/rtk-ai/rtk) | Proxy CLI token-aware | Filtra/comprime salida de comandos | macOS + Linux |
| Catppuccin | Tema | Latte (light) / Mocha (dark), dinámico | macOS + Linux |

---

## Preview

> Añade aquí capturas de pantalla de tu setup.
> Sugerencia: `CMD+Shift+4` para capturar región, luego arrastra los archivos a esta sección.

---

## Requisitos

### macOS (Homebrew)

```bash
brew install neovim git stow
brew install --cask wezterm aerospace zed
```

### Arch Linux (pacman)

```bash
sudo pacman -S neovim git stow wezterm hyprland
# Zed: yay -S zed (AUR) o descarga desde zed.dev
```

### Fuente

CommitMono Nerd Font (requerida por Neovim y WezTerm para iconos):

```bash
brew install --cask font-commit-mono-nerd-font   # macOS
# Arch: yay -S ttf-commit-mono-nerd-font
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

`install.sh` detecta el OS y linkea con `stow` los paquetes correspondientes desde `config/` hacia `~/.config`:

```bash
cd ~/dotfiles
./install.sh
```

Esto linkea `nvim`, `wezterm` y `zed` en ambos OS, más `aerospace` en macOS o `hypr` en Linux. Para linkear paquetes puntuales:

```bash
./install.sh nvim          # solo Neovim
./install.sh nvim hypr     # varios paquetes
```

Equivalente manual sin el script (por si quieres invocar `stow` directamente):

```bash
mkdir -p ~/.config
stow -d ~/dotfiles/config -t ~/.config nvim wezterm zed
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
| Insert | `<C-k>` | Signature help |
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

Para añadir más servidores edita `config/nvim/lua/plugins/init.lua` en la sección `ensure_installed` de `mason-lspconfig` y añade el nombre del server (e.g. `"pyright"`, `"rust_analyzer"`).

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

Cada carpeta bajo `config/` es un paquete de [GNU Stow](https://www.gnu.org/software/stow/): `install.sh` los symlinkea individualmente a `~/.config/<paquete>`.

```
dotfiles/
├── install.sh                      # Detecta OS y corre stow por paquete
└── config/
    ├── aerospace/                  # Solo macOS
    │   └── aerospace.toml          # Window manager config
    ├── hypr/                       # Solo Linux
    │   ├── hyprland.lua            # Config principal (formato Lua de Hyprland)
    │   ├── hypridle.conf
    │   ├── hyprlock.conf
    │   ├── hyprpaper.conf.unused
    │   └── scripts/                # Helpers (color-scheme, clipboard, powermenu)
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
    ├── kitty/
    │   ├── kitty.conf              # Terminal config
    │   └── theme.conf              # Catppuccin Mocha
    ├── gh/
    │   └── config.yml              # Preferencias de GitHub CLI (sin credenciales)
    ├── glow/
    │   └── glow.yml                # Preferencias de renderizado Markdown
    ├── rtk/
    │   ├── config.toml             # Config global de rtk
    │   └── filters.toml            # Filtros globales de salida
    └── zed/
        └── settings.json           # Zed config
```

> **Nota sobre `gh`**: `~/.config/gh/hosts.yml` (el token OAuth de autenticación) **no** está en este repo ni se symlinkea — es una credencial, se genera localmente con `gh auth login` en cada máquina.

---

## Personalización

### Cambiar el tema

El tema Catppuccin es consistente en todas las herramientas. Para cambiar el flavour (latte, frappe, macchiato, mocha) edita:

- **Neovim**: `config/nvim/lua/plugins/ui.lua` → `flavour`
- **WezTerm**: `config/wezterm/wezterm.lua` → `color_scheme`
- **Zed**: `config/zed/settings.json` → `theme.light` / `theme.dark`

### Añadir LSP servers

En `config/nvim/lua/plugins/init.lua`, dentro de `mason-lspconfig`:

```lua
ensure_installed = {
  "ts_ls",
  "lua_ls",
  "pyright",        -- Python
  "rust_analyzer",  -- Rust
},
```

### Ajustar gaps de Aerospace

En `config/aerospace/aerospace.toml`:

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
