local has_impatient,impatient = pcall(require,"impatient")
if has_impatient then
    impatient.enable_profile()
end
local has_filetype, filetype = pcall(require,"filetype")
if has_filetype then
    filetype.setup({})
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local LISP_LANG = {"scheme", "guile", "fennel", "hy", "racket"}
local DEV_LANG = {"go", "gomod", "gosum", "python", "sh", 'lua', "thrift", "sql", "fennel", "scheme"}
local DOTFILE_LANG = {'fennel', 'lua'}
local CONFIG_LANG = {'json', 'toml', 'yaml'}
local DOCUMENT_LANG = {"markdown", "org", "rst"}

local packer = require('packer')
packer.init({
    profile = {
        enable = true,
        threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
    }
})

packer.startup(function(use)
    -- performance
    use {'lewis6991/impatient.nvim'}
    use{"nathom/filetype.nvim"}
    use {'wbthomason/packer.nvim'}

    -- lua
    use {'folke/neodev.nvim', ft = DOTFILE_LANG}
    -- fennel
    use 'Olical/nvim-local-fennel'
    use { 'Olical/aniseed', config = function ()
        vim.g["aniseed#env"] = { module = "dotfiles.init", compile = true }
    end }

    -- macros
    use {'Olical/fennel.vim', ft = "fennel"}
    use {'Olical/conjure', ft = LISP_LANG}
    use {'udayvir-singh/hibiscus.nvim', ft = 'fennel'}
    use {'nvim-lua/plenary.nvim'}
    use {'tsbohc/zest.nvim', ft = {'fennel'}}

    -- ui
    use 'feline-nvim/feline.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'yamatsum/nvim-nonicons'
    use {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
    use { "ellisonleao/gruvbox.nvim" , config = function ()
        vim.cmd.colorscheme ("gruvbox")
    end }
    use {'edluffy/hologram.nvim', ft = DOCUMENT_LANG}

    -- ux
    use 'folke/which-key.nvim'
    use 'Nexmean/caskey.nvim'
    use 'rcarriga/nvim-notify'
    use 'romgrk/barbar.nvim'
    use 'RRethy/vim-illuminate'
    use { "luukvbaal/nnn.nvim", config = function() require("nnn").setup() end }
    use {'sidebar-nvim/sidebar.nvim', config = function ()
        require("sidebar-nvim").setup({open = false})
    end}


    -- editor
    use {'mbbill/undotree', ft=DEV_LANG}
    use {'mfussenegger/nvim-lint', ft=DEV_LANG}
    use {'tpope/vim-surround', ft=DEV_LANG}
    use {'tpope/vim-repeat', ft=DEV_LANG}
    use {'tpope/vim-abolish', ft=DEV_LANG}
    use {'tpope/vim-commentary', ft=DEV_LANG}
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
    use { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }

    -- startup & ext
    use 'tweekmonster/startuptime.vim'
    use {'tpope/vim-dadbod', ft=DEV_LANG}
    use {'kristijanhusak/vim-dadbod-ui', ft=DEV_LANG, requires = 'tpope/vim-dadbod'}

    -- treesitter
    use 'nvim-treesitter/nvim-treesitter'
    use {
        'm-demare/hlargs.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        ft = DEV_LANG
    }
    use {'romgrk/nvim-treesitter-context',  ft = DEV_LANG}
    use { "danymat/neogen", ft = DEV_LANG , requires = "nvim-treesitter/nvim-treesitter", config = function()
        require('neogen').setup {}
    end }
    use {'kosayoda/nvim-lightbulb',  ft = DEV_LANG, requires = 'antoinemadec/FixCursorHold.nvim' , config = function()
        require('nvim-lightbulb').setup({autocmd = {enabled = true}})
    end}
    use {'folke/trouble.nvim', ft = DEV_LANG}

    -- lsp management
    use { "williamboman/mason.nvim" , config = function () require("mason").setup() end }
    use { "williamboman/mason-lspconfig" , config = function () require("mason-lspconfig").setup() end , requires = "williamboman/mason.nvim" }
    use {'neovim/nvim-lspconfig', ft = DEV_LANG, config = function()
        lspconfig = require('lspconfig')
        lspconfig['pyright'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }
        lspconfig['fennel-ls'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }
        lspconfig['gopls'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }
        lspconfig['sumneko_lua'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {'vim'},
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
        lspconfig['racket_langserver'].setup{
            on_attach = on_attach,
            flags = lsp_flags,
        }
    end}
    use {'jose-elias-alvarez/null-ls.nvim',  ft = DEV_LANG}
    use {'folke/lsp-colors.nvim', ft = DEV_LANG}
    use {'mfussenegger/nvim-dap',  ft = DEV_LANG}
    use {'rcarriga/nvim-dap-ui',  ft = DEV_LANG}
    use {'theHamsta/nvim-dap-virtual-text', ft = DEV_LANG}

    -- background
    use {'idanarye/nvim-buffls', ft = DEV_LANG  }
    use {'idanarye/nvim-moonicipal', ft = DEV_LANG}

    -- completion
    use {'hrsh7th/cmp-nvim-lsp', ft = DEV_LANG}
    use {'hrsh7th/cmp-buffer' , ft = DEV_LANG}
    use {'hrsh7th/cmp-path', ft = DEV_LANG}
    use {'hrsh7th/cmp-cmdline', ft = DEV_LANG}
    use {'saadparwaiz1/cmp_luasnip', ft = DEV_LANG}
    use {'hrsh7th/nvim-cmp', config = function ()
        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local luasnip = require("luasnip")
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
                        -- they way you will only jump inside the snippet region
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })
    end }

    -- snippet
    use {'rafamadriz/friendly-snippets'}
    use { "L3MON4D3/LuaSnip", run = "make install_jsregexp", config = function ()
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}

use {'b0o/SchemaStore.nvim', ft = 'json'}

-- git
use { 'sindrets/diffview.nvim', requires = {'nvim-lua/plenary.nvim'}}
use { 'TimUntersberger/neogit', requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'}, config = function ()
    require('neogit').setup({
        integrations = {
            diffview = true
        }})
    end }

    -- telescope
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-hop.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-frecency.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-project.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-packer.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-snippets.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-file-browser.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use {'tom-anders/telescope-vim-bookmarks.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use { "LinArcX/telescope-command-palette.nvim" , requires = 'nvim-telescope/telescope.nvim'}
    use 'nvim-lua/popup.nvim'
    use 'cbochs/grapple.nvim'
    use 'vijaymarupudi/nvim-fzf'
    use {'ThePrimeagen/harpoon', config = function ()
        require("harpoon").setup()
    end}

    -- language support
    use {'kristijanhusak/orgmode.nvim', ft = 'org'}
    use {'wlangstroth/vim-racket', ft = {'racket'}}
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
    use {'rafaelsq/nvim-goc.lua', config = function ()
        require('nvim-goc').setup({ verticalSplit = false })
    end}

    -- markdown
    use {"ellisonleao/glow.nvim", ft = 'markdown', config = function() require('glow').setup() end}

    -- yaml
    use {
        "cuducos/yaml.nvim",
        ft = {"yaml"}, -- optional
        requires = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim" -- optional
        },
    }
    use {
        "someone-stole-my-name/yaml-companion.nvim",
        requires = {
            { "neovim/nvim-lspconfig" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("telescope").load_extension("yaml_schema")
        end,
        ft='yaml',
    }
    use {'gennaro-tedesco/nvim-jqx', ft={'json', 'jq'}}

    -- general development
    use {'hkupty/iron.nvim', opt=true}

    -- lisp
    use {'gpanders/nvim-parinfer', ft = LISP_LANG}
    use {'guns/vim-sexp', ft = LISP_LANG}
    use {'tpope/vim-sexp-mappings-for-regular-people',ft = LISP_LANG, requires = 'guns/vim-sexp'}
    use {'kovisoft/slimv', ft={'scheme'}}

end)

