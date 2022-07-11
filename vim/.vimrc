syntax on
set number
set mouse=a             " can select text and scroll with mouse
set numberwidth=1       " linenum width
set relativenumber      " linenums are relative now (abs in ruler)
set clipboard=unnamed   " copy to the OS clipboard
set showcmd             " show running command
set ruler               " show row/col on vim
set encoding=utf-8
set showmatch           " highlight matching braces
set sw=2                " 2 space indent
set shell=/bin/zsh

" Onedark config
" https://github.com/joshdick/onedark.vim
" needs colors/onedark.vim in ~/.vim/colors/ directory
" and autoload/onedark.vim in ~/.vim/autoload/ directory

" let g:onedark_color_overrides = {
" \ "black": {"gui": "#161616", "cterm": "NONE", "cterm16": "0" }
" \}

" colorscheme onedark
" let g:airline_theme='onedark'
" set background=dark

let g:airline_section_x = ''
let g:airline_section_y = ''

colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"
hi Normal ctermbg=None

" Indentation
filetype plugin indent on
" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab

set nocompatible              " be iMproved, required
filetype off                  " required
set autochdir                 " set dir to current file

" Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/goyo.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'junegunn/fzf'
" Plugin 'enricobacis/vim-airline-clock'
" Plugin 'joshdick/onedark.vim'
Plugin 'morhetz/gruvbox'
Plugin 'lilydjwg/colorizer'
Plugin 'vim-syntastic/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'grep.vim'
Plugin 'mattn/emmet-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'mhinz/vim-startify'
Plugin 'easymotion/vim-easymotion'
Plugin 'neoclide/coc.nvim'
Plugin 'lukas-reineke/indent-blankline.nvim'
" Ranger
" Plugin 'iberianpig/ranger-explorer.vim'
" Plugin 'rbgrouleff/bclose.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" Ranger
let g:ranger_explorer_keymap_edit    = '<C-o>'
let g:ranger_explorer_keymap_tabedit = '<C-t>'
let g:ranger_explorer_keymap_split   = '<C-s>'
let g:ranger_explorer_keymap_vsplit  = '<C-v>'
nnoremap <silent><Leader>n :RangerOpenCurrentFile<CR>
nnoremap <silent><Leader>c :RangerOpenCurrentDir<CR>
nnoremap <silent><Leader>f :RangerOpenProjectRootDir<CR>

" Easymotion
let mapleader=" "
nmap <Leader>s <Plug>(easymotion-s2)

map <C-n> :NERDTreeToggle<CR>
map <C-g> :Goyo<CR>
map <C-s> :SyntasticToggleMode<CR>

" Splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set splitright
set splitbelow

" Make adjusing split sizes a bit more friendly
" <C-arrows> don't work with Mission Control on macOS
noremap <silent><Leader><Left> :vertical resize +3<CR>
noremap <silent><Leader><Right> :vertical resize -3<CR>
noremap <silent><Leader><Up> :resize +3<CR>
noremap <silent><Leader><Down> :resize -3<CR>

" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>
:noremap <F3> :set nu! nu?<CR>

" Linter stuff
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:user_emmet_leader_key=','

let g:mustache_abbreviations = 1

" Code folding
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Autocompletion coc.vim and others
" Give more space for displaying messages.
" set cmdheight=2
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics - WTF is this?
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Snippets
let g:coc_snippet_next = '<tab>'
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" coc.vim extensions
let g:coc_global_extensions = [
  \'coc-prettier',
  \'coc-html',
  \'coc-tsserver',
  \'coc-json',
  \'coc-eslint',
  \'coc-git',
  \'coc-snippets',
  \]

command! -nargs=0 Prettier :CocCommand prettier.formatFile


let g:ascii = [
      \ '                                           ,o88888',
      \ '                                        ,o8888888*',
      \ '                  ,:o:o:oooo.        ,8O88Pd8888"',
      \ '              ,.::.::o:ooooOoOoO. ,oO8O8Pd888*"',
      \ '            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"',
      \ '           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"',
      \ '          , ..:.::o:ooOoOO8O888O8O,COCOO"',
      \ '         , . ..:.::o:ooOoOOOO8OOOOCOCO"',
      \ '          . ..:.::o:ooOoOoOO8O8OCCCC"o',
      \ '             . ..:.::o:ooooOoCoCCC"o:o',
      \ '             . ..:.::o:o:,cooooCo"oo:o:',
      \ '          `   . . ..:.:cocoooo"*o:o:::*',
      \ '          .`   . ..::ccccoc"*o:o:o:::*',
      \ '         :.:.    ,c:cccc"*:.:.:.:.:.*',
      \ '       ..:.:"*`::::c:"*..:.:.:.:.:.*',
      \ '     ...:.*.:.::::"*    . . . . .*',
      \ '    .. . ....:."* `   .  . . **',
      \ '  . . . ...."*',
      \ '  .. . ."*',
      \ ' .',
      \ ''
      \]

let g:startify_custom_header = startify#pad(g:ascii + split(system('fortune ~/my-dot-files/fortune/ror'), '\n'))
