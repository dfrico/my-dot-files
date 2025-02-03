return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
    })
    vim.cmd.colorscheme "catppuccin"
  end
}

-- return {
--   "maxmx03/solarized.nvim",
--   name = "solarized",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.o.background = 'light' -- or 'light'
--     vim.cmd.colorscheme 'solarized'
--   end
-- }
