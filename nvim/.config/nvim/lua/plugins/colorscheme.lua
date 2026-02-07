-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                           COLORSCHEME                                     ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

return {
  -- Tokyo Night - Beautiful dark theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night", -- night, storm, day, moon
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal", "packer", "NvimTree" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = true,
      lualine_bold = true,
      on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = "#ff757f"
      end,
      on_highlights = function(hl, c)
        -- Make the cursor line more visible
        hl.CursorLine = { bg = c.bg_highlight }
        -- Nicer floating windows
        hl.FloatBorder = { fg = c.blue, bg = c.bg_float }
        hl.NormalFloat = { bg = c.bg_float }
        -- Better telescope
        hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
        hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
        hl.TelescopePromptNormal = { bg = c.bg_highlight }
        hl.TelescopePromptBorder = { bg = c.bg_highlight, fg = c.bg_highlight }
        hl.TelescopePromptTitle = { bg = c.blue, fg = c.bg_dark }
        hl.TelescopePreviewTitle = { bg = c.green, fg = c.bg_dark }
        hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Alternative: Catppuccin (uncomment to use instead)
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     flavour = "mocha", -- latte, frappe, macchiato, mocha
  --     transparent_background = false,
  --     term_colors = true,
  --     integrations = {
  --       cmp = true,
  --       gitsigns = true,
  --       nvimtree = true,
  --       telescope = true,
  --       treesitter = true,
  --       which_key = true,
  --       indent_blankline = { enabled = true },
  --       native_lsp = { enabled = true },
  --     },
  --   },
  --   config = function(_, opts)
  --     require("catppuccin").setup(opts)
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
}
