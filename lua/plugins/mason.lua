require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "tsserver", "clangd", "rust_analyzer" },
})

