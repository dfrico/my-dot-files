-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP Configuration & Plugins
    use {
        'neovim/nvim-lspconfig',
        requires = { -- Automatically install LSPs to stdpath for neovim
        'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
        'j-hui/fidget.nvim', -- Additional lua configuration, makes nvim stuff amazing
        'folke/neodev.nvim'}
    }

    -- Treesitter - better syntax detection and highlight
    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update {
                with_sync = true
            })
        end
    }

    -- Telescope fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- UI
    use 'rhysd/git-messenger.vim'
    use 'lewis6991/gitsigns.nvim'

    use 'nvim-lualine/lualine.nvim'

    use 'lukas-reineke/indent-blankline.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

    use 'psliwka/vim-smoothie'

    -- Utils
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'skywind3000/asyncrun.vim'
    use 'numToStr/Comment.nvim'

    -- Colorschemes
    use({
        "catppuccin/nvim",
        as = "catppuccin"
    })
    use 'norcalli/nvim-colorizer.lua'
    use 'cormacrelf/dark-notify'

    -- Languages
    use 'sebdah/vim-delve'

    -- Misc
    use 'LnL7/vim-nix'

    -- Rosé Pine theme for neovim
    -- use({
    --   'rose-pine/neovim',
    --   as = 'rose-pine',
    --   config = function()
    -- 	  vim.cmd('colorscheme rose-pine')
    --   end
    -- })

    -- old vim packages
    -- 'scrooloose/nerdtree'
    -- 'junegunn/goyo.vim'
    -- 'vim-airline/vim-airline'
    -- 'junegunn/fzf' <- fuzzy finder
    -- 'lilydjwg/colorizer'
    -- 'airblade/vim-gitgutter'
    -- 'grep.vim' <- required for fuzzy finder ?
    -- 'mattn/emmet-vim'
    -- 'mhinz/vim-startify' <- improved start screen
    -- 'easymotion/vim-easymotion' <- navigate quickly to any word
    -- 'neoclide/coc.nvim' <- code autocompletion
    -- 'lukas-reineke/indent-blankline.nvim'

end)

-- CONFIG - WIP
-- require("plugins.config")
