-- Fonction simple pour activer/désactiver un LSP par nom
local function toggle_lsp(server_name)
  local lspconfig = require('lspconfig')
  local clients = vim.lsp.get_active_clients()
  
  -- Vérifier si le LSP est déjà actif
  for _, client in ipairs(clients) do
    if client.name == server_name then
      -- LSP actif -> le désactiver
      vim.lsp.stop_client(client.id)
      print("❌ " .. server_name .. " désactivé")
      return
    end
  end
  
  -- LSP pas actif -> l'activer
  if lspconfig[server_name] then
    lspconfig[server_name].setup({})
    print("✅ " .. server_name .. " activé")
  else
    print("⚠️  LSP inconnu: " .. server_name)
  end
end

-- Créer les commandes pour chaque LSP
local lsp_servers = {
  "ts_ls",
  "rust_analyzer", 
  "lua_ls",
  "html",
  "cssls",
  "jsonls",
  "eslint",
  "emmet_ls",
  "pyright",
  "gopls",
  "clangd",
  "bashls",
  "yamlls"
}

-- Commande générale
vim.api.nvim_create_user_command('Lsp', function(opts)
  local server_name = opts.args
  if server_name == "" then
    print("Usage: :Lsp <nom_serveur>")
    print("Serveurs disponibles: " .. table.concat(lsp_servers, ", "))
    return
  end
  toggle_lsp(server_name)
end, { 
  nargs = 1,
  complete = function(arg_lead, cmd_line, cursor_pos)
    local matches = {}
    for _, server in ipairs(lsp_servers) do
      if server:find(arg_lead, 1, true) then
        table.insert(matches, server)
      end
    end
    return matches
  end
})

-- Commandes spécifiques pour tes LSP principaux
vim.api.nvim_create_user_command('LspTS', function()
  toggle_lsp('ts_ls')
end, {})

vim.api.nvim_create_user_command('LspRust', function()
  toggle_lsp('rust_analyzer')
end, {})

vim.api.nvim_create_user_command('LspLua', function()
  toggle_lsp('lua_ls')
end, {})

vim.api.nvim_create_user_command('LspHTML', function()
  toggle_lsp('html')
end, {})

vim.api.nvim_create_user_command('LspCSS', function()
  toggle_lsp('cssls')
end, {})

vim.api.nvim_create_user_command('LspJSON', function()
  toggle_lsp('jsonls')
end, {})

-- Keymaps rapides
vim.keymap.set('n', '<leader>lt', ':LspTS<CR>', { desc = 'Toggle TypeScript LSP' })
vim.keymap.set('n', '<leader>lr', ':LspRust<CR>', { desc = 'Toggle Rust LSP' })
vim.keymap.set('n', '<leader>ll', ':LspLua<CR>', { desc = 'Toggle Lua LSP' })

print("✅ LSP Toggle chargé - Utilise :Lsp <nom> ou :LspTS, :LspRust, etc.")
