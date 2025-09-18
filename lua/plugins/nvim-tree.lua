	return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Note: Les icônes sont configurées dans jetbrains-icons.lua
		-- Désactiver netrw (important !)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			-- Configuration de base
			sort_by = "name",
			view = {
				width = 35,
				side = "left",
			},
			renderer = {
				add_trailing = false,
				group_empty = false,
				highlight_git = true,
				full_name = false,
				highlight_opened_files = "none",
				root_folder_modifier = ":~",
				indent_width = 2,
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						none = " ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "before",
					modified_placement = "after",
					padding = " ",
					symlink_arrow = " ➞ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
					},
				glyphs = {
					-- Icônes Nerd Font modernes
					default = "", -- Fichier par défaut
					symlink = "", -- Lien symbolique
					bookmark = "󰆤", -- Signet
					modified = "●", -- Fichier modifié (point)
					folder = {
						-- Flèches pour expand/collapse
						arrow_closed = "▶", -- Flèche fermée (ou utiliser )
						arrow_open = "▼", -- Flèche ouverte (ou utiliser )
						-- Dossiers avec icônes Nerd Font
						default = "󰉋", -- Dossier fermé
						open = "󰝰", -- Dossier ouvert  
						empty = "󰉖", -- Dossier vide
						empty_open = "󰷏", -- Dossier vide ouvert
						symlink = "󱧮", -- Lien dossier
						symlink_open = "󱧯", -- Lien dossier ouvert
					},
					git = {
						-- Statut Git avec icônes
						unstaged = "", -- Modifié
						staged = "", -- Ajouté 
						unmerged = "", -- Conflit
						renamed = "➡", -- Renommé
						untracked = "", -- Non suivi
						deleted = "", -- Supprimé
						ignored = "◌", -- Ignoré
					},
				},
				},
			},
			filters = {
				dotfiles = false,
				custom = { ".DS_Store" },
			},
			git = {
				enable = true,
				ignore = false,
				show_on_dirs = true,
				timeout = 400,
			},
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				open_file = {
					quit_on_open = false,
					resize_window = true,
					window_picker = {
						enable = false, -- Désactivé pour éviter blocages
					},
				},
			},
		})

		-- Configuration pour la transparence
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				local transparent_groups = {
					"NvimTreeNormal",
					"NvimTreeNormalNC",
					"NvimTreeVertSplit",
					"NvimTreeWinSeparator",
					"NvimTreeEndOfBuffer",
				}
				for _, group in ipairs(transparent_groups) do
					vim.api.nvim_set_hl(0, group, { bg = "NONE" })
				end
			end,
		})

		-- Appliquer immédiatement la transparence
		vim.schedule(function()
			local transparent_groups = {
				"NvimTreeNormal",
				"NvimTreeNormalNC",
				"NvimTreeVertSplit",
				"NvimTreeWinSeparator",
				"NvimTreeEndOfBuffer",
			}
			for _, group in ipairs(transparent_groups) do
				vim.api.nvim_set_hl(0, group, { bg = "NONE" })
			end
		end)

		-- Mappings
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })
		vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<cr>", { desc = "Find current file in NvimTree" })
		
		-- Commande pour tester les icônes style JetBrains
		vim.api.nvim_create_user_command('TestTreeIcons', function()
			print("=== Test des icônes JetBrains nvim-tree ===")
			local devicons = require('nvim-web-devicons')
			
			print("Icônes style JetBrains (lettres colorées):")
			local test_files = {
				{ "app.js", "JavaScript" },
				{ "main.ts", "TypeScript" },
				{ "component.jsx", "React JSX" },
				{ "config.json", "JSON" },
				{ "init.lua", "Lua" },
				{ "main.py", "Python" },
				{ "main.rs", "Rust" },
				{ "style.css", "CSS" },
				{ "README.md", "Markdown" },
				{ "package.json", "NPM" }
			}
			
			for _, file_info in ipairs(test_files) do
				local file, desc = file_info[1], file_info[2]
				local icon, color = devicons.get_icon(file, vim.fn.fnamemodify(file, ":e"))
				if icon then
					-- Créer un affichage coloré si possible
					if color then
						vim.api.nvim_echo({
							{ icon .. " ", "Normal" },
							{ file .. " ", "Normal" },
							{ "(" .. desc .. ")", "Comment" }
						}, false, {})
					else
						print(string.format("%s %s (%s)", icon, file, desc))
					end
				else
					print(string.format("❌ %s (pas d'icône %s)", file, desc))
				end
			end
			
			print("\nDossiers et navigation:")
			print("▶ [DIR] Dossier fermé")
			print("▼ [OPEN] Dossier ouvert")
			print("📄 Fichier par défaut")
			
			print("\nStatut Git:")
			print("M - Modifié | A - Ajouté | D - Supprimé | ? - Non suivi")
			
			print("\n🎆 Style JetBrains activé !")
			print("Les icônes utilisent des lettres/sigles au lieu de symboles.")
			print("Ouvrez nvim-tree avec <leader>e pour voir le résultat !")
		end, { desc = "Test des icônes JetBrains nvim-tree" })
		
		-- Keymap pour tester rapidement
		vim.keymap.set("n", "<leader>ti", "<cmd>TestTreeIcons<cr>", { desc = "Test Tree Icons" })
	end,
}
