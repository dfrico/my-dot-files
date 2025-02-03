-- lualine: vim airline/statusline replacement
-- https://github.com/nvim-lualine/lualine.nvim

-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

local colors = {
  -- TODO: theming
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  -- black  = '#080808',
  black  = '#1e1e2d',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

-- LIGHT THEME
-- local colors = {
--   base03  = '#002b36',
--   base02  = '#073642',
--   base01  = '#586e75',
--   base00  = '#657b83',
--   base0   = '#839496',
--   base1   = '#93a1a1',
--   base2   = '#eee8d5',
--   black   = '#fdf6e3',
--   yellow  = '#b58900',
--   orange  = '#cb4b16',
--   red     = '#dc322f',
--   magenta = '#d33682',
--   -- violet  = '#6c71c4',
--   blue    = '#268bd2',
--   violet    = '#2aa198',
--   green   = '#859900',
-- }

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

return {
  'nvim-lualine/lualine.nvim',
  -- dependencies = { 'kyazdani42/nvim-web-devicons', opt = true }
  -- added by neotree so not necessary here
  config = function()
    -- Bubbles config goes here
    require('lualine').setup {
      options = {
        theme = bubbles_theme,
        component_separators = '|',
        -- section_separators = { left = '', right = '' },
      },
      sections = {
        -- lualine_a = {
        --   { 'mode', separator = { left = '' }, right_padding = 2 },
        -- },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { 'fileformat' },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        -- lualine_z = {
        --   { 'location', separator = { right = '' }, left_padding = 2 },
        -- },
      },
      inactive_sections = {
        -- lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        -- lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    }
  end
}
