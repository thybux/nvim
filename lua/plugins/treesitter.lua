return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
				-- Langages à installer automatiquement
				ensure_installed = {
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"json",
					"lua",
					"vim",
					"vimdoc",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"yaml",
					"toml",
					"bash",
					"regex",
					"vue",
				},

			-- Installation synchrone au démarrage
			sync_install = false,
			auto_install = true,

			-- Coloration syntaxique
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			-- Indentation intelligente
			indent = {
				enable = true,
			},

			-- Sélection incrémentale
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<TAB>",
					node_decremental = "<S-TAB>",
				},
			},

			-- Objets textuels (ex: sélectionner une fonction)
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},
			},
		})

		-- Activer le folding basé sur Treesitter
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldenable = false -- Désactivé par défaut
	end,
}
