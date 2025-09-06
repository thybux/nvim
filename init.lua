vim.g.maplocalleader = " "

-- Charger les configurations
require("config.options")
require("config.keymaps")
require("config.window-cycle")
require("config.lazy")

vim.opt.clipboard = "unnamed"

vim.cmd([[colorscheme tokyonight]])
