return {
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			-- Configuration signature automatique
			require("lsp_signature").setup({
				bind = true,
				floating_window = true,
				hint_enable = true,
				auto_close_after = 3,
				handler_opts = { border = "rounded" },
				trigger_on_newline = true,
				auto_signature_help = true,
				-- Apparence
				floating_window_above_cur_line = true,
				transparency = 10,
				shadow_blend = 36,
				shadow_guibg = "Black",
			})

			-- Configuration globale LSP
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
				focusable = false,
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "rounded",
				focusable = false,
			})

			-- Fonction on_attach commune
			local on_attach = function(client, bufnr)
				-- Mappings LSP
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Documentation" }))
				vim.keymap.set(
					"n",
					"<C-k>",
					vim.lsp.buf.signature_help,
					vim.tbl_extend("force", opts, { desc = "Signature" })
				)
				vim.keymap.set(
					"i",
					"<C-k>",
					vim.lsp.buf.signature_help,
					vim.tbl_extend("force", opts, { desc = "Signature en insertion" })
				)
				vim.keymap.set(
					"n",
					"gd",
					vim.lsp.buf.definition,
					vim.tbl_extend("force", opts, { desc = "Aller à la définition" })
				)
				vim.keymap.set(
					"n",
					"gr",
					vim.lsp.buf.references,
					vim.tbl_extend("force", opts, { desc = "Références" })
				)
				vim.keymap.set(
					"n",
					"<leader>rn",
					vim.lsp.buf.rename,
					vim.tbl_extend("force", opts, { desc = "Renommer" })
				)
				vim.keymap.set(
					"n",
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Actions de code" })
				)([[-- Auto-format au save (optionnel)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end --]])
			end

			-- Configuration Volar (Vue.js)
			require("lspconfig").volar.setup({
				on_attach = on_attach,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				filetypes = { "vue", "typescript", "javascript" },
				init_options = {
					vue = {
						hybridMode = false,
					},
				},
			})

			-- Configuration ESLint
			require("lspconfig").eslint.setup({
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					-- Auto-fix ESLint au save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
				settings = {
					workingDirectory = { mode = "auto" },
				},
			})

			-- Hover automatique après inactivité (optionnel)
			vim.opt.updatetime = 1000 -- 1 seconde
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					-- Vérifie qu'on est sur un symbole avant d'afficher
					local params = vim.lsp.util.make_position_params()
					vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result)
						if result and result.contents then
							vim.lsp.buf.hover()
						end
					end)
				end,
			})

			-- Diagnostics configuration
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
				},
			})

			-- Icônes pour les diagnostics
			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
