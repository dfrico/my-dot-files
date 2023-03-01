-- Telescope fuzzy finder
return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.0',
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  config = function()
    function TelescopeFileSearch()
      local input_string = vim.fn.input("Search For > ")
      if (input_string == '') then
        return
      end
      require("telescope.builtin").grep_string({
        search = input_string,
      })
    end

    vim.keymap.set('n', '<C-f>', ':lua TelescopeFileSearch()<CR>', { noremap = false, silent = false });
    -- :Telescope live_grep <CR> could be a good alternative
  end
}
