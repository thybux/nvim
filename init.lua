-- Définir la touche leader
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.cmdheight = 3
-- vim.opt.number = true
vim.opt.relativenumber = true
-- Chemin pour lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.tabstop = 2

-- Installer lazy.nvim s'il n'est pas déjà installé
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- chrager l'ui
require("ui_colors")

-- Configuration des plugins avec lazy.nvim
require("lazy").setup({
	-- Mason pour gérer les LSP
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},

	-- ajout du formater de code au moment du :w
	{
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				filetype = {
					lua = {
						function()
							return {
								exe = "stylua",
								args = { "--search-parent-directories", "-" },
								stdin = true,
							}
						end,
					},
					python = {
						function()
							return {
								exe = "black",
								args = { "-" },
								stdin = true,
							}
						end,
					},
					javascript = {
						function()
							return {
								exe = "prettier",
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
								stdin = true,
							}
						end,
					},
					typescript = {
						function()
							return {
								exe = "prettier",
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
								stdin = true,
							}
						end,
					},
					rust = {
						function()
							return {
								exe = "rustfmt",
								args = { "--emit=stdout" },
								stdin = true,
							}
						end,
					},
				},
			})

			-- Automatically format on save
			vim.api.nvim_exec(
				[[
          augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost * FormatWrite
          augroup END
        ]],
				true
			)
		end,
	},

	-- mason-lspconfig pour une intégration facile avec lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,
			})
		end,
	},
	--[[{
    'Mofiqul/dracula.nvim',
    config = function()
      require('dracula').setup({
        -- Activer les options
        transparent_bg = false, -- Désactiver la transparence (fond opaque)
        italic_comment = true,  -- Commentaires en italique (facultatif)
      })
      vim.cmd("colorscheme dracula") -- Applique le thème
    end,
  },--]]

	-- Configuration des LSP
	{
		"neovim/nvim-lspconfig",
	},
	-- Affichage des indentations (version 2)
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "v2", -- Spécifier la version 2
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},
	-- Affichage des couleurs hexadécimales
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- Navigation améliorée avec Harpoon
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup()
			-- Raccourcis pour Harpoon
			vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
			vim.keymap.set("n", "<leader>h", require("harpoon.ui").toggle_quick_menu)
		end,
	},
	-- Coloration syntaxique avancée avec Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- Remplace 'run' par 'build' pour lazy.nvim
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "python", "javascript" }, -- Ajoutez les langages que vous utilisez
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	-- Recherche de fichiers avec Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({})
			-- Raccourcis pour Telescope
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},
	-- Autocomplétion avec nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Source pour LSP
			"hrsh7th/cmp-buffer", -- Source pour buffer actuel
			"hrsh7th/cmp-path", -- Source pour les chemins de fichiers
			"hrsh7th/cmp-cmdline", -- Source pour la ligne de commande
			"L3MON4D3/LuaSnip", -- Moteur de snippets
			"saadparwaiz1/cmp_luasnip", -- Source pour LuaSnip
			"rafamadriz/friendly-snippets", -- Snippets prédéfinis
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			-- Charger les snippets prédéfinis
			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			-- Configuration pour la ligne de commande
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
				},
			})
		end,
	},
	-- Gestion des paires avec nvim-autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
			-- Intégration avec nvim-cmp
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	-- Arborescence des fichiers avec nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	-- Barre des fichiers ouverts avec bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	},
	-- Terminal intégré avec toggleterm
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({})
		end,
	},
	-- Jeu pour s'entraîner aux commandes Vim
	{
		"ThePrimeagen/vim-be-good",
		cmd = { "VimBeGood" },
	},
})

-- Ouvrir nvim-tree avec <leader>e
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Ouvrir un terminal avec <leader>t
vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { noremap = true, silent = true })

-- Lancer le jeu vim-be-good avec <leader>g
vim.keymap.set("n", "<leader>g", ":VimBeGood<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		local python_path = get_python_path()
		require("lspconfig").pyright.setup({
			settings = {
				python = {
					pythonPath = python_path,
				},
			},
		})
	end,
})

vim.opt.guifont = "JetBrains Mono:h14"
