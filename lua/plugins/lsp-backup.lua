return {
	-- Configuration LSP moderne pour Neovim 0.11.3
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "hrsh7th/cmp-nvim-lsp" },
			-- Plugin pour le progrès LSP
			{ "j-hui/fidget.nvim", opts = {} },
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Capacités LSP avec nvim-cmp
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			
			-- Amélioration pour gros projets
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}

			-- Fonction on_attach commune
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }

				-- Keymaps LSP
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<leader>f', function()
					vim.lsp.buf.format({ async = true })
				end, opts)

				-- Diagnostics
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
				vim.keymap.set('n', '<leader>dl', vim.diagnostic.open_float, opts)
				vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, opts)

				-- Optimisation pour gros projets
				if client.name == "ts_ls" then
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end
			end

			-- Configuration Mason pour installation automatique
			local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
			if mason_lspconfig_ok then
				mason_lspconfig.setup({
					ensure_installed = {
						'ts_ls', 'eslint', 'rust_analyzer', 'pyright', 'lua_ls'
					},
					automatic_installation = true,
				})
			end

			-- Setup direct des LSP servers (compatible Neovim 0.11.3)
			local lspconfig = require('lspconfig')

			-- TypeScript/JavaScript optimisé
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					typescript = {
						maxTsServerMemory = 8192,
						preferences = {
							quotePreference = "double",
							includeCompletionsForModuleExports = true,
							includeCompletionsForImportStatements = true,
						},
						inlayHints = {
							includeInlayParameterNameHints = 'all',
							includeInlayVariableTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = 'all',
							includeInlayVariableTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
						},
					},
				},
			})

			-- ESLint
			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.cmd("EslintFixAll")
						end,
					})
				end,
			})

			-- Rust Analyzer
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					['rust-analyzer'] = {
						checkOnSave = { command = 'clippy' },
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						inlayHints = {
							chainInlayHints = true,
							parameterHints = true,
							typeHints = true,
						},
					},
				},
			})

			-- Python
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			-- Lua pour config Neovim
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
							telemetry = { enable = false },
					},
				},
			})

			-- Configuration globale des diagnostics
			vim.diagnostic.config({
				virtual_text = {
					prefix = '●',
					source = "if_many",
					spacing = 2,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = 'rounded',
					source = 'always',
				},
			})

			-- Icônes de diagnostics
			local signs = {
				Error = '⚠',
				Warn = '⚠',
				Hint = '💡',
				Info = 'ℹ',
			}
			for type, icon in pairs(signs) do
				local hl = 'DiagnosticSign' .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- Commands personnalisées
			vim.api.nvim_create_user_command('LspRestart', function()
				local clients = vim.lsp.get_clients()
				for _, client in pairs(clients) do
					client.stop()
				end
				vim.defer_fn(function()
					vim.cmd('edit')
				end, 500)
			end, { desc = 'Restart LSP' })

		vim.api.nvim_create_user_command('LspInfo', 'LspInfo', { desc = 'LSP Information' })
		end,
	},
}
