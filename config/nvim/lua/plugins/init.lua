return {
  -- Explorador de archivos
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file tree", silent = true },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",       desc = "Find files" },
      { "<leader>fa", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find all files (hidden)" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",        desc = "Live grep" },
      { "gd",         "<cmd>Telescope lsp_definitions<cr>",  desc = "Definitions" },
      { "gr",         "<cmd>Telescope lsp_references<cr>",   desc = "References" },
      { "gi",         "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            i = { ["<esc>"] = actions.close },
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local langs = { "lua", "typescript", "javascript", "tsx", "rust", "json", "markdown", "vim", "vimdoc", "query" }
      require("nvim-treesitter").install(langs)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function() pcall(vim.treesitter.start) end,
      })
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("lualine").setup {
        options = {
          theme = "auto",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_b = { "branch", "diff" },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            "encoding",
            "filetype",
          },
        },
      }
    end
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
        terminal_colors = true,
        styles = {
          comments = { "italic" },
          keywords = { "italic" },
        },
        integrations = {
          nvimtree = true,
          telescope = { enabled = true },
          bufferline = true,
          mini = { enabled = true },
          treesitter = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      })

      -- Detecta el tema del sistema macOS y aplica Mocha (dark) o Latte (light)
      local function get_system_flavor()
        local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null"):gsub("%s+", "")
        return result == "Dark" and "mocha" or "latte"
      end

      local function apply_theme()
        local flavor = get_system_flavor()
        vim.o.background = flavor == "latte" and "light" or "dark"
        vim.cmd.colorscheme("catppuccin-" .. flavor)
        local ok, lualine = pcall(require, "lualine")
        if ok then lualine.refresh() end
      end

      apply_theme()

      -- Observa cambios en el tema del sistema cada 2 segundos
      local timer = vim.uv.new_timer()
      local last_flavor = get_system_flavor()
      timer:start(2000, 2000, vim.schedule_wrap(function()
        local current = get_system_flavor()
        if current ~= last_flavor then
          last_flavor = current
          apply_theme()
        end
      end))
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "ts_ls", "lua_ls", "jsonls" },
        automatic_enable = { exclude = { "stylua" } },
      }
      vim.lsp.config("ts_ls", {})
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }
            }
          }
        }
      })
      vim.lsp.config("jsonls", {})
      vim.lsp.enable({ "ts_ls", "lua_ls", "jsonls" })
    end
  }

}
