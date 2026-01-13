return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        native_lsp = {
          enabled = true,
        },
        treesitter = true,
        telescope = true,
        which_key = true,
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          -- Sync terminal background with editor background
          TermCursor = { bg = colors.rosewater },
          TermCursorNC = { bg = colors.overlay1 },
        }
      end,
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "carbonfox",
      -- colorscheme = "dawnfox",
      -- colorscheme = "catppuccin-macchiato", -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
      -- colorscheme = "catppuccin-latte",
    },
  },
}
