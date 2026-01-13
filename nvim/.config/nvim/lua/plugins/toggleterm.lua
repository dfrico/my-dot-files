return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<C-`>]],
      direction = "vertical",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      shade_terminals = false, -- Don't apply shading, use colorscheme colors
      highlights = {
        Normal = {
          link = "Normal",
        },
        NormalFloat = {
          link = "Normal",
        },
      },
    },
  },
}
