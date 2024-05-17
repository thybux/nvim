-- lua/plugins/lspconfig.lua

local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Configuration de mason
mason.setup()

-- Configuration de mason-lspconfig
mason_lspconfig.setup({
    ensure_installed = { "pyright", "tsserver", "clangd", "rust_analyzer" },
    automatic_installation = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Fonction pour configurer automatiquement les serveurs LSP
mason_lspconfig.setup_handlers({
    function(server_name) -- Fonction par défaut pour tous les serveurs LSP
        lspconfig[server_name].setup {
            capabilities = capabilities,
        }
    end,
})

-- Configuration des serveurs LSP supplémentaires manuellement
-- (si besoin de configurations spécifiques)
lspconfig.pyright.setup {
    capabilities = capabilities,
}

lspconfig.tsserver.setup {
    capabilities = capabilities,
}

lspconfig.clangd.setup {
    capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
}

