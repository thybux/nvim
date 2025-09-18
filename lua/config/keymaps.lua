vim.g.mapleader = " "

-- Raccourcis généraux
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Déplacer les lignes sélectionnées
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
local opts = { silent = true }

vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)

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

-- Formatage UNIQUEMENT MANUEL pour ne pas casser vos règles projet
-- Utilisez <leader>mp pour formater manuellement si vraiment nécessaire
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	local choice = vim.fn.confirm("Vraiment formater? (Attention aux règles du projet!)", "&Oui\n&Non", 2)
	if choice == 1 then
		require("conform").format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		})
		print("✅ Formaté manuellement")
	else
		print("❌ Formatage annulé")
	end
end, { desc = "[MANUEL] Formater le fichier (demande confirmation)" })

-- Sauvegarder SANS formater
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Sauvegarder sans formater" })

-- Info sur l'état du formatage
vim.keymap.set("n", "<leader>mf", function()
	print("🔴 Formatage automatique DÉSACTIVÉ")
	print("Utilisez <leader>mp pour formater manuellement si nécessaire")
	print("Utilisez <leader>w pour sauvegarder sans formater")
end, { desc = "Info sur formatage" })

-- Voir les formatters disponibles
vim.keymap.set("n", "<leader>mi", "<cmd>ConformInfo<cr>", { desc = "Info formatters" })

vim.keymap.set("n", "<leader>bd", function()
	local buffers = vim.fn.getbufinfo({ buflisted = 1 })
	if #buffers > 1 then
		vim.cmd("bd")
	else
		vim.cmd("q")
	end
end, { desc = "Close buffer or quit if last" })

-- Diagnostic pour problèmes de démarrage
vim.keymap.set("n", "<leader>dd", function()
	print("=== Diagnostic Neovim ===")
	print("Plugins chargés:")
	local plugins = require("lazy").stats()
	print("  Total: " .. plugins.count)
	print("  Chargés: " .. plugins.loaded)
	print("Messages:")
	vim.cmd("messages")
end, { desc = "Diagnostic startup" })
