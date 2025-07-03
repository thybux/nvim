vim.g.mapleader = " "

-- Raccourcis généraux
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Déplacer les lignes sélectionnées
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Raccourcis Neo-tree
vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true })

-- Charger la fonction de cycle de fenêtres
local window_cycle = require('config.window-cycle')

-- Raccourci principal pour cycler entre les fenêtres
vim.keymap.set("n", "<leader><tab>", window_cycle.cycle_windows, {
  desc = "Cycle: Neo-tree → Éditeur → Terminal",
  silent = true
})
