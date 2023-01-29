return require('packer').startup(function(use) 
    use 'Olical/nvim-local-fennel'
    use { 'Olical/aniseed', run = function () 
        vim.g["aniseed#env"] = { module = "dotfiles.init", compile = true } 
    end }
    use 'Olical/fennel.vim'
    use 'Olical/conjure'
    use 'tpope/vim-vinegar'
    use {'Shougo/deoplete.nvim', cmd = 'UpdateRemotePlugins', run = function() 
        vim.g["deoplete#enable_at_startup"] = 1 
    end }

    use 'wbthomason/packer.nvim'
    use 'hrsh7th/nvim-compe'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'tsbohc/zest.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use 'yamatsum/nvim-nonicons'
    use 'glepnir/zephyr-nvim'
    use 'norcalli/nvim-colorizer.lua'
    use 'glepnir/galaxyline.nvim'

    use 'francoiscabrol/ranger.vim'
    use 'kyazdani42/nvim-tree.lua'
    use 'folke/which-key.nvim'
    use 'sharefantasy/transient'
    use 'rcarriga/nvim-notify'
    use 'romgrk/barbar.nvim'

    use 'Olical/vim-enmasse'
    use 'PeterRincker/vim-argumentative'
    use 'jiangmiao/auto-pairs'
    use 'mbbill/undotree'
    use 'haya14busa/incsearch.vim'
    use 'dense-analysis/ale'
    use 'guns/vim-sexp'
    use 'tpope/vim-sexp-mappings-for-regular-people'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-repeat'
    use 'tpope/vim-abolish'
    use 'tpope/vim-commentary'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-sleuth'
    use 'justinmk/vim-sneak'
    use 'norcalli/snippets.nvim'

    use 'tweekmonster/startuptime.vim'
    use 'tpope/vim-dadbod'
    use 'tpope/vim-dispatch'
    use 'radenling/vim-dispatch-neovim'
    use 'akinsho/nvim-toggleterm.lua'
    use 'neomake/neomake'
    use 'glacambre/firenvim'

    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'glepnir/lspsaga.nvim'
    use 'folke/lsp-colors.nvim'
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'romgrk/nvim-treesitter-context'
    use 'kosayoda/nvim-lightbulb'
    use 'folke/trouble.nvim'

    use 'lewis6991/gitsigns.nvim'
    use 'sindrets/diffview.nvim'
    use 'TimUntersberger/neogit'

    use 'vijaymarupudi/nvim-fzf'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-hop.nvim'
    use 'nvim-telescope/telescope-frecency.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    use 'nvim-telescope/telescope-snippets.nvim'
    use 'MattesGroeger/vim-bookmarks'
    use 'tom-anders/telescope-vim-bookmarks.nvim'

    use 'kristijanhusak/orgmode.nvim'
    use 'wlangstroth/vim-racket'
    use 'ray-x/go.nvim'
    use { "ellisonleao/gruvbox.nvim" , config = function () 
        vim.cmd.colorscheme ("gruvbox") 
    end }

end)

