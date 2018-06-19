syntax on
colorscheme onedark
let g:airline_theme='onedark'
"set background=dark

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" added nerdtree
Plugin 'scrooloose/nerdtree'

Plugin 'vim-airline/vim-airline'
Plugin 'enricobacis/vim-airline-clock'
Plugin 'lilydjwg/colorizer'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

map <C-n> :NERDTreeToggle<CR>
