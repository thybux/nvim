return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Désactiver netrw (important !)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({})

		-- Mapping simple
		vim.keymap.set("n", "<leader>e", function()
			print("Mapping appelé !") -- Pour voir si ça s'exécute
			vim.cmd("NvimTreeToggle")
		end, { desc = "Toggle NvimTree" })
	end,
}
