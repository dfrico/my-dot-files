-- LSP Configuration & Plugins
return {
  'neovim/nvim-lspconfig',
  dependencies = { -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
    'j-hui/fidget.nvim', -- Additional lua configuration, makes nvim stuff amazing
    'folke/neodev.nvim' }
}
