(module dotfiles.init {require {nvim aniseed.nvim mapping dotfiles.mapping}})

; :highlight NormalFloat ctermbg=<colour> guibg=<colour>
(set nvim.g.maplocalleader ",")
(nvim.ex.highlight "NormalFloat ctermbg=black guibg=black")

(set nvim.o.mouse :a)
(set nvim.o.termguicolors true)

(set nvim.o.number true)
(set nvim.o.relativenumber true)

(set nvim.o.tabstop 4)
(set nvim.o.shiftwidth 4)
(set nvim.o.expandtab true)

(set nvim.o.background :dark)

(set nvim.o.clipboard :unnamedplus)
