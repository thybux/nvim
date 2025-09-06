return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- ou "tabs"
				numbers = "none", -- ou "ordinal", "buffer_id", etc.
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				-- Séparateurs
				separator_style = "slant", -- ou "thick", "thin", "slope"
				-- Affichage
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				-- Diagnostics LSP
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = false,
				-- Longueur max des noms
				max_name_length = 18,
				max_prefix_length = 15,
				truncate_names = true,
				tab_size = 21,
			},
		})
	end,
}
