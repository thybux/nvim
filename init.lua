-- Configuration principale Neovim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Charger les configurations dans l'ordre
require("config.options")
require("config.keymaps") 
require("config.window-cycle")
require("config.lazy")
