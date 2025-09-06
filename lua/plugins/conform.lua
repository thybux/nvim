return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				-- Ajoutez seulement les langages que vous utilisez
			},
			format_on_save = false,
			[[--{
        timeout_ms = 500,
        lsp_fallback = true,
    },--]],
		})
	end,
}
