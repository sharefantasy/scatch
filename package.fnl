(local (has-impatient impatient) (pcall require :impatient))

(when has-impatient
  (impatient.enable_profile))

(local (has-filetype filetype) (pcall require :filetype))

(when has-filetype
  (filetype.setup {}))

(local opts {:noremap true :silent true})

(vim.keymap.set :n :<space>e vim.diagnostic.open_float opts)

(vim.keymap.set :n "[d" vim.diagnostic.goto_prev opts)

(vim.keymap.set :n "]d" vim.diagnostic.goto_next opts)

(vim.keymap.set :n :<space>q vim.diagnostic.setloclist opts)

(fn on-attach [client bufnr]
  ((. (require :lsp-format) :on_attach) client)
  (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
  (local bufopts {:buffer bufnr :noremap true :silent true})
  (vim.keymap.set :n :gD vim.lsp.buf.declaration bufopts)
  (vim.keymap.set :n :gd vim.lsp.buf.definition bufopts)
  (vim.keymap.set :n :K vim.lsp.buf.hover bufopts)
  (vim.keymap.set :n :gi vim.lsp.buf.implementation bufopts)
  (vim.keymap.set :n :<C-k> vim.lsp.buf.signature_help bufopts)
  (vim.keymap.set :n :<space>wa vim.lsp.buf.add_workspace_folder bufopts)
  (vim.keymap.set :n :<space>wr vim.lsp.buf.remove_workspace_folder bufopts)
  (vim.keymap.set :n :<space>wl
                  (fn []
                    (print (vim.inspect (vim.lsp.buf.list_workspace_folders))))
                  bufopts)
  (vim.keymap.set :n :<space>D vim.lsp.buf.type_definition bufopts)
  (vim.keymap.set :n :<space>rn vim.lsp.buf.rename bufopts)
  (vim.keymap.set :n :<space>ca vim.lsp.buf.code_action bufopts)
  (vim.keymap.set :n :gr vim.lsp.buf.references bufopts)
  (vim.keymap.set :n :<space>f
                  (fn []
                    (vim.lsp.buf.format {:async true}))
                  bufopts))

(local lsp-flags {:debounce_text_changes 150})

(local LISP_LANG [:scheme :guile :fennel :hy :racket])

(local DEV_LANG [:go
                 :gomod
                 :gosum
                 :python
                 :sh
                 :lua
                 :thrift
                 :sql
                 :fennel
                 :scheme])

(local DOTFILE_LANG [:fennel :lua])

(local DOCUMENT_LANG [:markdown :org :rst])

(local packer (require :packer))

(packer.init {:profile {:enable true :threshold 1}})

(packer.startup (fn [use]
                  (use [:lewis6991/impatient.nvim])
                  (use [:nathom/filetype.nvim])
                  (use [:wbthomason/packer.nvim])
                  (use {1 :folke/neodev.nvim :ft DOTFILE_LANG})
                  (use :Olical/nvim-local-fennel)
                  (use {1 :Olical/aniseed
                        :config (fn []
                                  (tset vim.g "aniseed#env"
                                        {:compile true :module :dotfiles.init}))})
                  (use {1 :Olical/fennel.vim :ft :fennel})
                  (use {1 :Olical/conjure :ft LISP_LANG})
                  (use {1 :udayvir-singh/hibiscus.nvim :ft :fennel})
                  (use [:nvim-lua/plenary.nvim])
                  (use {1 :tsbohc/zest.nvim :ft [:fennel]})
                  (use :feline-nvim/feline.nvim)
                  (use :kyazdani42/nvim-web-devicons)
                  (use :yamatsum/nvim-nonicons)
                  (use {1 :ray-x/guihua.lua :run "cd lua/fzy && make"})
                  (use {1 :ellisonleao/gruvbox.nvim
                        :config (fn []
                                  (vim.cmd.colorscheme :gruvbox))})
                  (use {1 :jacoborus/tender.vim :config (fn [])})
                  (use {1 :edluffy/hologram.nvim :ft DOCUMENT_LANG})
                  (use :folke/which-key.nvim)
                  (use :Nexmean/caskey.nvim)
                  (use :rcarriga/nvim-notify)
                  (use :romgrk/barbar.nvim)
                  (use :RRethy/vim-illuminate)
                  (use {1 :luukvbaal/nnn.nvim
                        :config (fn []
                                  ((. (require :nnn) :setup)))})
                  (use {1 :sidebar-nvim/sidebar.nvim
                        :config (fn []
                                  ((. (require :sidebar-nvim) :setup) {:open false}))})
                  (use [:xiyaowong/virtcolumn.nvim])
                  (use {1 :mbbill/undotree :ft DEV_LANG})
                  (use {1 :mfussenegger/nvim-lint :ft DEV_LANG})
                  (use {1 :kylechui/nvim-surround
                        :config (fn []
                                  ((. (require :nvim-surround) :setup)))})
                  (use {1 :tpope/vim-repeat :ft DEV_LANG})
                  (use {1 :tpope/vim-abolish :ft DEV_LANG})
                  (use {1 :tpope/vim-commentary :ft DEV_LANG})
                  (use {1 :phaazon/hop.nvim
                        :config (fn []
                                  ((. (require :hop) :setup) {:keys :etovxqpdygfblzhckisuran}))})
                  (use {1 :chrisgrieser/nvim-various-textobjs
                        :config (fn []
                                  ((. (require :various-textobjs) :setup) {:useDefaultKeymaps true}))})
                  (use [:mhartington/formatter.nvim])
                  (use {1 :windwp/nvim-autopairs
                        :config (fn []
                                  ((. (require :nvim-autopairs) :setup) {:disable_filetype [:TelescopePrompt
                                                                                            :guihua
                                                                                            :guihua_rust
                                                                                            :clap_input]}))})
                  (use {1 :ray-x/navigator.lua
                        :config (fn []
                                  ((. (require :navigator) :setup))
                                  (when (and (and (= vim.o.ft :clap_input)
                                                  (= vim.o.ft :guihua))
                                             (= vim.o.ft :guihua_rust))
                                    ((. (. (require :cmp) :setup) :buffer) {:completion {:enable false}})))})
                  (use :tweekmonster/startuptime.vim)
                  (use {1 :tpope/vim-dadbod :ft DEV_LANG})
                  (use {1 :kristijanhusak/vim-dadbod-ui
                        :ft DEV_LANG
                        :requires :tpope/vim-dadbod})
                  (use {1 :m-demare/hlargs.nvim :ft DEV_LANG})
                  (use :nvim-treesitter/nvim-treesitter)
                  (use {1 :romgrk/nvim-treesitter-context :ft DEV_LANG})
                  (use :nvim-treesitter/nvim-treesitter-refactor)
                  (use {1 :danymat/neogen
                        :config (fn []
                                  ((. (require :neogen) :setup) {}))
                        :ft DEV_LANG})
                  (use {1 :kosayoda/nvim-lightbulb
                        :config (fn []
                                  ((. (require :nvim-lightbulb) :setup) {:autocmd {:enabled true}}))
                        :ft DEV_LANG
                        :requires :antoinemadec/FixCursorHold.nvim})
                  (use {1 :folke/trouble.nvim :ft DEV_LANG})
                  (use {1 :williamboman/mason.nvim
                        :config (fn []
                                  ((. (require :mason) :setup)))})
                  (use {1 :williamboman/mason-lspconfig
                        :config (fn []
                                  ((. (require :mason-lspconfig) :setup) {:ensure_installed [:sumneko_lua
                                                                                             :gopls
                                                                                             :pyright
                                                                                             :sqls]}))
                        :requires :williamboman/mason.nvim})
                  (use {1 :neovim/nvim-lspconfig
                        :config (fn []
                                  (local lspconfig (require :lspconfig))
                                  ((. (. lspconfig :pyright) :setup) {:flags lsp-flags
                                                                      :on_attach on-attach})
                                  ((. (. lspconfig :gopls) :setup) {:flags lsp-flags
                                                                    :on_attach on-attach})
                                  ((. (. lspconfig :sumneko_lua) :setup) {:flags lsp-flags
                                                                          :on_attach on-attach
                                                                          :settings {:Lua {:diagnostics {:globals [:vim
                                                                                                                   :hs]}
                                                                                           :runtime {:version :LuaJIT}
                                                                                           :telemetry {:enable false}
                                                                                           :workspace {:checkThirdParty false
                                                                                                       :library (vim.api.nvim_get_runtime_file ""
                                                                                                                                               true)}}}})
                                  ((. (. lspconfig :racket_langserver) :setup) {:flags lsp-flags
                                                                                :on_attach on-attach})
                                  ((. (. lspconfig :bashls) :setup) {:flags lsp-flags
                                                                     :on_attach on-attach}))
                        :ft DEV_LANG})
                  (use [:lukas-reineke/lsp-format.nvim])
                  (use {1 :jose-elias-alvarez/null-ls.nvim
                        :config (fn []
                                  (local null-ls (require :null-ls))
                                  (null-ls.setup {:sources [null-ls.builtins.completion.luasnip]}))
                        :ft DEV_LANG})
                  (use {1 :folke/lsp-colors.nvim :ft DEV_LANG})
                  (use {1 :mfussenegger/nvim-dap :ft DEV_LANG})
                  (use {1 :rcarriga/nvim-dap-ui :ft DEV_LANG})
                  (use {1 :theHamsta/nvim-dap-virtual-text :ft DEV_LANG})
                  (use {1 :idanarye/nvim-buffls :ft DEV_LANG})
                  (use {1 :idanarye/nvim-moonicipal :ft DEV_LANG})
                  (use {1 :idanarye/nvim-channelot :ft DEV_LANG})
                  (use {1 :hrsh7th/cmp-nvim-lsp :ft DEV_LANG})
                  (use {1 :hrsh7th/cmp-buffer :ft DEV_LANG})
                  (use {1 :hrsh7th/cmp-path :ft DEV_LANG})
                  (use {1 :hrsh7th/cmp-cmdline :ft DEV_LANG})
                  (use {1 :saadparwaiz1/cmp_luasnip :ft DEV_LANG})
                  (use {1 :hrsh7th/nvim-cmp
                        :config (fn []
                                  (fn has-words-before []
                                    (local (line col)
                                           (unpack (vim.api.nvim_win_get_cursor 0)))
                                    (and (not= col 0)
                                         (= (: (: (. (vim.api.nvim_buf_get_lines 0
                                                                                 (- line
                                                                                    1)
                                                                                 line
                                                                                 true)
                                                     1)
                                                  :sub col col)
                                               :match "%s")
                                            nil)))

                                  (local luasnip (require :luasnip))
                                  (local cmp (require :cmp))
                                  (cmp.setup {:mapping (cmp.mapping.preset.insert {:<C-Space> (cmp.mapping.complete)
                                                                                   :<C-b> (cmp.mapping.scroll_docs (- 4))
                                                                                   :<C-e> (cmp.mapping.abort)
                                                                                   :<C-f> (cmp.mapping.scroll_docs 4)
                                                                                   :<CR> (cmp.mapping.confirm {:select true})
                                                                                   :<S-Tab> (cmp.mapping (fn [fallback]
                                                                                                           (if (cmp.visible)
                                                                                                               (cmp.select_prev_item)
                                                                                                               (luasnip.jumpable (- 1))
                                                                                                               (luasnip.jump (- 1))
                                                                                                               (fallback)))
                                                                                                         [:i
                                                                                                          :s])
                                                                                   :<Tab> (cmp.mapping (fn [fallback]
                                                                                                         (if (cmp.visible)
                                                                                                             (cmp.select_next_item)
                                                                                                             (luasnip.expand_or_jumpable)
                                                                                                             (luasnip.expand_or_jump)
                                                                                                             (has-words-before)
                                                                                                             (cmp.complete)
                                                                                                             (fallback)))
                                                                                                       [:i
                                                                                                        :s])})
                                              :snippet {:expand (fn [args]
                                                                  ((. (require :luasnip)
                                                                      :lsp_expand) args.body))}
                                              :sources (cmp.config.sources [{:name :nvim_lsp}
                                                                            {:name :luasnip}
                                                                            {:name :buffer}
                                                                            {:name :path}
                                                                            {:name :cmdline}])
                                              :window {:completion (cmp.config.window.bordered)
                                                       :documentation (cmp.config.window.bordered)}}))})
                  (use [:rafamadriz/friendly-snippets])
                  (use {1 :L3MON4D3/LuaSnip
                        :config (fn []
                                  ((. (require :luasnip.loaders.from_vscode)
                                      :lazy_load)))
                        :run "make install_jsregexp"})
                  (use {1 :b0o/SchemaStore.nvim :ft :json})
                  (use {1 :sindrets/diffview.nvim
                        :requires [:nvim-lua/plenary.nvim]})
                  (use {1 :TimUntersberger/neogit
                        :config (fn []
                                  ((. (require :neogit) :setup) {:integrations {:diffview true}}))
                        :requires [:nvim-lua/plenary.nvim
                                   :sindrets/diffview.nvim]})
                  (use :nvim-telescope/telescope.nvim)
                  (use {1 :nvim-telescope/telescope-hop.nvim
                        :requires :nvim-telescope/telescope.nvim})
                  (use {1 :nvim-telescope/telescope-frecency.nvim
                        :requires :nvim-telescope/telescope.nvim})
                  (use {1 :nvim-telescope/telescope-project.nvim
                        :requires :nvim-telescope/telescope.nvim})
                  (use {1 :nvim-telescope/telescope-packer.nvim
                        :requires :nvim-telescope/telescope.nvim})
                  (use {1 :nvim-telescope/telescope-snippets.nvim
                        :requires :nvim-telescope/telescope.nvim})
                  (use {1 :nvim-telescope/telescope-file-browser.nvim
                        :requires :nvim-telescope/telescope.nvim})
                  (use {1 :tom-anders/telescope-vim-bookmarks.nvim
                        :requires :nvim-telescope/telescope.nvim})
                  (use {1 :LinArcX/telescope-command-palette.nvim
                        :requires :nvim-telescope/telescope.nvim})
                  (use :nvim-lua/popup.nvim)
                  (use :cbochs/grapple.nvim)
                  (use :vijaymarupudi/nvim-fzf)
                  (use {1 :ThePrimeagen/harpoon
                        :config (fn []
                                  ((. (require :harpoon) :setup)))})
                  (use {1 :kristijanhusak/orgmode.nvim :ft :org})
                  (use {1 :wlangstroth/vim-racket :ft [:racket :scheme]})
                  (use {1 :ray-x/go.nvim
                        :config (fn []
                                  (local format-sync-grp
                                         (vim.api.nvim_create_augroup :GoFormat
                                                                      {}))
                                  (vim.api.nvim_create_autocmd :BufWritePre
                                                               {:callback (fn []
                                                                            ((. (require :go.format)
                                                                                :goimport)))
                                                                :group format-sync-grp
                                                                :pattern :*.go})
                                  ((. (require :go) :setup)))
                        :ft :go})
                  (use {1 :rafaelsq/nvim-goc.lua
                        :config (fn []
                                  ((. (require :nvim-goc) :setup) {:verticalSplit false}))})
                  (use {1 :ellisonleao/glow.nvim
                        :config (fn []
                                  ((. (require :glow) :setup)))
                        :ft :markdown})
                  (use {1 :cuducos/yaml.nvim
                        :ft [:yaml]
                        :requires [:nvim-telescope/telescope.nvim]})
                  (use {1 :someone-stole-my-name/yaml-companion.nvim
                        :config (fn []
                                  ((. (require :telescope) :load_extension) :yaml_schema))
                        :ft :yaml
                        :requires [[:neovim/nvim-lspconfig]
                                   [:nvim-lua/plenary.nvim]
                                   [:nvim-telescope/telescope.nvim]]})
                  (use {1 :gennaro-tedesco/nvim-jqx :ft [:json :jq]})
                  (use {1 :hkupty/iron.nvim :opt true})
                  (use {1 :gpanders/nvim-parinfer :ft LISP_LANG})
                  (use {1 :guns/vim-sexp :ft LISP_LANG})
                  (use {1 :tpope/vim-sexp-mappings-for-regular-people
                        :ft LISP_LANG
                        :requires :guns/vim-sexp})
                  (use {1 :kovisoft/slimv :ft {}})))

