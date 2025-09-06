return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
	},
	config = function()
		local lspconfig = require("lspconfig")

		local enable_servers = {
			typescript = true, -- typescript-language-server
			lua = true, -- lua-language-server
		}

		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			local opts = { buffer = bufnr, silent = true }

			-- Navigation de base
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

			-- Actions essentielles
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, opts)

			-- Diagnostics
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

			-- print("✅ LSP " .. client.name .. " connecté au buffer")
		end

		-- Lua (lua-language-server)
		if enable_servers.lua then
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end

		-- TypeScript/JavaScript (typescript-language-server)
		if enable_servers.typescript then
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
		})

		-- Icônes simples pour diagnostics
		local signs = {
			Error = "E",
			Warn = "W",
			Hint = "H",
			Info = "I",
		}
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.api.nvim_create_user_command("LspStatus", function()
			local clients = vim.lsp.get_active_clients()
			if #clients == 0 then
			-- print("❌ Aucun serveur LSP actif")
			-- print("Ouvrez un fichier .lua, .js, .php, .rs ou .py")
			else
				-- print("✅ Serveurs LSP actifs:")
				for _, client in pairs(clients) do
					-- print("  - " .. client.name)
				end
			end
		end, {})

		vim.api.nvim_create_user_command("LspTest", function()
			-- print("🧪 Test des serveurs LSP configurés:")
			local servers = { "lua_ls", "ts_ls", "intelephense", "rust_analyzer", "pyright" }
			for _, server in pairs(servers) do
				local config = lspconfig[server]
				-- if config then
				--   print("  ✅ " .. server .. " - Configuré")
				-- else
				--  print("  ❌ " .. server .. " - Non configuré")
				--end
			end
			-- print("")
			-- print("💡 Conseil: Ouvrez un fichier du bon type pour activer le LSP")
		end, {})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				-- print("🎯 LSP " .. client.name .. " attaché au fichier " .. vim.fn.expand("%:t"))
			end,
		})

		-- print("🚀 LSP configuré avec Mason! Ouvrez un fichier pour tester.")
	end,
}
