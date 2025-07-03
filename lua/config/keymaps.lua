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

vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { 
  desc = "Onglet suivant", 
  silent = true 
})

vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { 
  desc = "Onglet précédent", 
  silent = true 
})



-- Raccourcis pour Codeium
vim.keymap.set("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, desc = "Accepter suggestion Codeium" })

vim.keymap.set("i", "<C-;>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, desc = "Suggestion suivante Codeium" })

vim.keymap.set("i", "<C-,>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, desc = "Suggestion précédente Codeium" })

vim.keymap.set("i", "<C-x>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true, desc = "Effacer suggestions Codeium" })

-- Commandes pour gérer Codeium
vim.keymap.set("n", "<leader>ce", ":Codeium Enable<CR>", { desc = "Activer Codeium" })
vim.keymap.set("n", "<leader>cd", ":Codeium Disable<CR>", { desc = "Désactiver Codeium" })
vim.keymap.set("n", "<leader>ct", ":Codeium Toggle<CR>", { desc = "Basculer Codeium" })

