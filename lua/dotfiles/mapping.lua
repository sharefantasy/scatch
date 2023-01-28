local _2afile_2a = "fnl/dotfiles/mapping.fnl"
local _2amodule_name_2a = "dotfiles.mapping"
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
local function setup()
  return print("setup")
end
_2amodule_2a["setup"] = setup
return _2amodule_2a