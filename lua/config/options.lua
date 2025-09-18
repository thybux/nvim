-- Configuration générale de l'éditeur
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamed"

-- Configuration d'indentation (sans doublons)
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true

-- Configuration pour l'affichage des icônes
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Indentation par type de fichier (override si nécessaire)
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"python",
		"java",
		"c",
		"cpp",
	},
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

-- Makefiles utilisent des vraies tabs
vim.api.nvim_create_autocmd("FileType", {
	pattern = "make",
	callback = function()
		vim.opt_local.expandtab = false
	end,
})
