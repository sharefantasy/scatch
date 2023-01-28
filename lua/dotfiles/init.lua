local _2afile_2a = "fnl/dotfiles/init.fnl"
local _2amodule_name_2a = "dotfiles.init"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local mapping, nvim = require("dotfiles.mapping"), require("aniseed.nvim")
do end (_2amodule_locals_2a)["mapping"] = mapping
_2amodule_locals_2a["nvim"] = nvim
nvim.g.maplocalleader = ","
nvim.ex.highlight("NormalFloat ctermbg=black guibg=black")
nvim.o.mouse = "a"
nvim.o.termguicolors = true
nvim.o.number = true
nvim.o.relativenumber = true
nvim.o.tabstop = 4
nvim.o.shiftwidth = 4
nvim.o.expandtab = true
nvim.o.background = "dark"
nvim.ex.colorscheme("gruvbox")
return _2amodule_2a