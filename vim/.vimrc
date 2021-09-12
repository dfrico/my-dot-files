syntax on
set mouse=a             " can select text and scroll with mouse
set numberwidth=1       " linenum width
set relativenumber      " linenums are relative now (abs in ruler)
set clipboard=unnamed   " copy to the OS clipboard
set showcmd             " show running command
set ruler               " show row/col on vim
set encoding=utf-8
set showmatch           " highlight matching braces
set sw=2                " 2 space indent

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

colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"

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
" Plugin 'enricobacis/vim-airline-clock'
" Plugin 'joshdick/onedark.vim'
Plugin 'morhetz/gruvbox'
Plugin 'lilydjwg/colorizer'
Plugin 'vim-syntastic/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'grep.vim'
Plugin 'mattn/emmet-vim'
" Plugin 'rust-lang/rust.vim'
Plugin 'mhinz/vim-startify'
Plugin 'easymotion/vim-easymotion'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

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

" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>
:noremap <F3> :set nu! nu?<CR>

" Linter stuff
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set shell=/usr/bin/zsh

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'
let g:user_emmet_leader_key=','

" Code folding
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2


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

let g:startify_custom_header = startify#pad(g:ascii + split(system('fortune ror'), '\n'))
