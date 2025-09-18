return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			-- Formatters optimisés pour chaque langage
			formatters_by_ft = {
			-- JavaScript/TypeScript - DÉSACTIVÉ pour respecter vos règles projet
			-- Décommentez ces lignes si vous voulez réactiver le formatage
			-- javascript = { "prettierd", "prettier" },
			-- javascriptreact = { "prettierd", "prettier" },
			-- typescript = { "prettierd", "prettier" },
			-- typescriptreact = { "prettierd", "prettier" },
			-- json = { "prettierd", "prettier" },
			-- jsonc = { "prettierd", "prettier" },
			-- html = { "prettierd", "prettier" },
			-- css = { "prettierd", "prettier" },
			-- scss = { "prettierd", "prettier" },
			-- markdown = { "prettierd", "prettier" },
			-- yaml = { "prettierd", "prettier" },
				
				-- Rust
				rust = { "rustfmt" },
				
				-- Python
				python = { "isort", "black" },
				
				-- Lua (pour config Neovim)
				lua = { "stylua" },
				
				-- Shell scripts
				sh = { "shfmt" },
				bash = { "shfmt" },
			},
			
			-- Configuration des formatters pour optimisation
			formatters = {
				prettierd = {
					-- Optimisation pour gros projets
					env = {
						PRETTIER_DEBUG = "0", -- Désactive debug
					},
				},
				rustfmt = {
					-- Configuration Rust
					args = { "--edition", "2021" },
				},
				shfmt = {
					-- Style shell scripts
					prepend_args = { "-i", "2", "-ci" },
				},
			},
			
			-- Format on save complètement désactivé
			format_on_save = false,
			
			-- Format after save aussi désactivé
			format_after_save = false,
		})
		
		-- Commands personnalisées
		vim.api.nvim_create_user_command("FormatToggle", function()
			local conform = require("conform")
			local format_on_save = conform.get_formatter_info().format_on_save
			if format_on_save then
				conform.setup({ format_on_save = nil })
				print("🔴 Auto-format désactivé")
			else
				conform.setup({
					format_on_save = {
						timeout_ms = 1000,
						lsp_fallback = true,
					},
				})
				print("🟢 Auto-format activé")
			end
		end, { desc = "Toggle format on save" })
	end,
}
