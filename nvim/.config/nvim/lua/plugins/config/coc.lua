-- coc.nvim - https://vimawesome.com/plugin/coc-nvim
return {
  'neoclide/coc.nvim',
  config = function()
    local g = vim.g
    local api = vim.api
    local cmd = api.nvim_command
    local fn = vim.fn

    -- function! s:check_back_space() abort
    --   let col = col('.') - 1
    --   return !col || getline('.')[col - 1]  =~# '\s'
    -- endfunction
    function _G.check_back_space()
      local col = fn.col('.') - 1
      if col == 0 or fn.getline('.'):sub(col, col):match('%s') then
        return true
      else
        return false
      end
    end

    -- Use tab for trigger completion with characters ahead and navigate.
    -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    -- other plugin before putting this into your config.

    -- inoremap <silent><expr> <TAB>
    --       \ pumvisible() ? "\<C-n>" :
    --       \ <SID>check_back_space() ? "\<TAB>" :
    --       \ coc#refresh()
    vim.keymap.set("i", "<TAB>", 'pumvisible() ? "<C-N>" : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
      { expr = true })
    -- inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    vim.keymap.set("i", "<S-TAB>", 'pumvisible() ? "<C-P>" : "<C-H>"', { expr = true })

    -- " Make <CR> auto-select the first completion item and notify coc.nvim to
    -- " format on enter, <cr> could be remapped by other vim plugin
    -- inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    --                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    vim.keymap.set("i", "<CR>", 'pumvisible() ? coc#_select_confirm() : "<C-G>u<CR><C-R>=coc#on_enter()<CR>"',
      { expr = true })

    -- " Use `[g` and `]g` to navigate diagnostics - WTF is this?
    -- " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    -- nmap <silent> [g <Plug>(coc-diagnostic-prev)
    -- nmap <silent> ]g <Plug>(coc-diagnostic-next)
    vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", { noremap = false })
    vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", { noremap = false })

    -- " GoTo code navigation.
    -- nmap <silent> gd <Plug>(coc-definition)
    -- nmap <silent> gy <Plug>(coc-type-definition)
    -- nmap <silent> gi <Plug>(coc-implementation)
    -- nmap <silent> gr <Plug>(coc-references)
    vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { noremap = false })
    vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { noremap = false })
    vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { noremap = false })
    vim.keymap.set("n", "gr", "<Plug>(coc-references)", { noremap = false })

    -- " Snippets
    -- let g:coc_snippet_next = '<tab>'
    -- " Use <C-l> for trigger snippet expand.
    -- imap <C-l> <Plug>(coc-snippets-expand)
    vim.keymap.set("i", "<C-l>", "<Plug>(coc-snippets-expand)")
    -- " Use <C-j> for select text for visual placeholder of snippet.
    -- vmap <C-j> <Plug>(coc-snippets-select)
    vim.keymap.set("v", "<C-j>", "<Plug>(coc-snippets-select)")
    -- " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    -- let g:coc_snippet_next = '<c-j>'
    -- " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    -- let g:coc_snippet_prev = '<c-k>'
    -- " Use <C-j> for both expand and jump (make expand higher priority.)
    -- imap <C-j> <Plug>(coc-snippets-expand-jump)
    vim.keymap.set("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)")
    -- " Use <leader>x for convert visual selected code to snippet
    -- xmap <leader>x  <Plug>(coc-convert-snippet)
    vim.keymap.set("x", "<leader>x", "<Plug>(coc-convert-snippet)")

    g.coc_global_extensions = {
      'coc-prettier',
      'coc-html',
      'coc-tsserver',
      'coc-json',
      'coc-eslint',
      'coc-git',
      'coc-snippets',
    }
  end
}
