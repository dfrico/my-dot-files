-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Install lazy.nvim if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- end of lazy install
-- packer migration guide: https://github.com/folke/lazy.nvim#-migration-guide

return require('lazy').setup("plugins/config")

-- TODO: check:
-- UI
-- 'rhysd/git-messenger.vim',
-- 'lewis6991/gitsigns.nvim', -- another ??
-- 'lukas-reineke/indent-blankline.nvim',
-- 'kyazdani42/nvim-web-devicons',
-- 'kyazdani42/nvim-tree.lua', -- also neotree ??
-- 'psliwka/vim-smoothie',

-- Utils
-- 'tpope/vim-fugitive', for git signs and stuff
-- 'tpope/vim-surround',
-- 'tpope/vim-repeat',
-- 'skywind3000/asyncrun.vim',
-- 'numToStr/Comment.nvim',

-- 'norcalli/nvim-colorizer.lua', -- colorizer
-- 'cormacrelf/dark-notify',

-- Misc
-- 'LnL7/vim-nix',

-- old vim packages
-- 'scrooloose/nerdtree' -> neotree - https://github.com/nvim-neo-tree/neo-tree.nvim
-- 'junegunn/goyo.vim' -> zen mode
-- 'vim-airline/vim-airline' -> lualine - https://github.com/nvim-lualine/lualine.nvim
-- 'junegunn/fzf' -> telescope
-- 'lilydjwg/colorizer' -> colorizer
-- 'airblade/vim-gitgutter' - https://github.com/airblade/vim-gitgutter
-- 'grep.vim' <- required for fuzzy finder ?
-- 'mattn/emmet-vim' -> skipped
-- 'mhinz/vim-startify' -> alpha
-- 'easymotion/vim-easymotion'
-- 'neoclide/coc.nvim' -> ?? lsp??
-- 'lukas-reineke/indent-blankline.nvim'
