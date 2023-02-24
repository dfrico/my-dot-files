-- Treesitter - better syntax detection and highlight
return {
  -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = function()
    pcall(require('nvim-treesitter.install').update {
      with_sync = true
    })
  end
}
