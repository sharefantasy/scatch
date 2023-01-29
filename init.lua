return require('packer').startup(function(use)
    -- lua
    use 'folke/neodev.nvim'
    -- fennel
    use 'Olical/nvim-local-fennel'
    use { 'Olical/aniseed', config = function ()
        vim.g["aniseed#env"] = { module = "dotfiles.init", compile = true }
    end }

    use {'Olical/fennel.vim', ft = 'fnl'}
    use 'Olical/conjure'
    use {'udayvir-singh/hibiscus.nvim', ft = 'fnl'}

    use {'Shougo/deoplete.nvim', cmd = 'UpdateRemotePlugins', run = function()
        vim.g["deoplete#enable_at_startup"] = 1
    end }

    use 'wbthomason/packer.nvim'
    use 'hrsh7th/nvim-compe'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'tsbohc/zest.nvim'
    use 'feline-nvim/feline.nvim'

    -- ui
    use 'kyazdani42/nvim-web-devicons'
    use 'yamatsum/nvim-nonicons'
    use 'glepnir/zephyr-nvim'
    use 'norcalli/nvim-colorizer.lua'
    use {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}

    -- ux
    use 'francoiscabrol/ranger.vim'
    use 'kyazdani42/nvim-tree.lua'
    use 'folke/which-key.nvim'
    use 'Nexmean/caskey.nvim'
    use 'rcarriga/nvim-notify'
    use 'romgrk/barbar.nvim'
    use 'RRethy/vim-illuminate'
    use {"shortcuts/no-neck-pain.nvim"}

    -- editor
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
    use { "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter", config = function()
        require('neogen').setup {}
    end }
    use {'phaazon/hop.nvim', config = function ()
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end }
    use {
        "chrisgrieser/nvim-various-textobjs",
        config = function ()
            require("various-textobjs").setup({ useDefaultKeymaps = true })
        end,
    }
    use { 'mhartington/formatter.nvim' }



    -- snippet
    use 'norcalli/snippets.nvim'
    use 'rafamadriz/friendly-snippets'
    use 'b0o/SchemaStore.nvim'
    use({ "L3MON4D3/LuaSnip", run = "make install_jsregexp" })
    use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }


    -- startup & ext
    use 'tweekmonster/startuptime.vim'
    use 'tpope/vim-dadbod'
    use 'tpope/vim-dispatch'
    use 'radenling/vim-dispatch-neovim'
    use 'akinsho/nvim-toggleterm.lua'
    use 'neomake/neomake'
    use 'glacambre/firenvim'


    -- lsp management
    use { "williamboman/mason.nvim" , config = function () require("mason").setup() end }
    use { "williamboman/mason-lspconfig" , config = function () require("mason-lspconfig").setup() end }
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

    -- git
    use 'lewis6991/gitsigns.nvim'
    use { 'sindrets/diffview.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use { 'TimUntersberger/neogit', requires = 'sindrets/diffview.nvim', config = function ()
        require('neogit').setup({
          integrations = {
            diffview = true
          }
        })
    end }

    -- telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-hop.nvim'
    use 'nvim-telescope/telescope-frecency.nvim'
    use 'nvim-telescope/telescope-project.nvim'
    use 'nvim-telescope/telescope-packer.nvim'
    use 'nvim-telescope/telescope-snippets.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use { "LinArcX/telescope-command-palette.nvim" }
    use 'nvim-lua/popup.nvim'
    use 'MattesGroeger/vim-bookmarks'
    use 'tom-anders/telescope-vim-bookmarks.nvim'
    use 'vijaymarupudi/nvim-fzf'

    -- language support
    use {'kristijanhusak/orgmode.nvim', ft = 'org'}
    use 'wlangstroth/vim-racket'
    use {'ray-x/go.nvim', ft = "go", config = function ()
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
           require('go.format').goimport()
          end,
          group = format_sync_grp,
        })
        require('go').setup()
    end }

    use { "ellisonleao/gruvbox.nvim" , config = function () 
        vim.cmd.colorscheme ("gruvbox") 
    end }

    -- markdown
    use {"ellisonleao/glow.nvim", ft = 'md', config = function() require('glow').setup() end}


    -- general development
    use 'hkupty/iron.nvim'

    -- performance
    use {'lewis6991/impatient.nvim', config = function () 
        require('impatient')
    end }
end)

