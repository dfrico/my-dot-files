if true then
  return {}
end

return {
  {
    "stevearc/profile.nvim",
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      indent = {
        enabled = false,
      },
      statuscolumn = {
        enabled = false,
      },
      words = {
        enabled = false,
      },
    },
  },
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = false,
  },
}
