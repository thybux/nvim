-- =============================================================================
-- ~/.config/nvim/lua/plugins/cmp.lua
-- VERSION CORRIGÉE avec Codeium
-- =============================================================================

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "jcdickinson/codeium.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
        { name = "codeium", priority = 1000 },  -- ✅ Priorité élevée pour Codeium
        { name = "nvim_lsp", priority = 900 },  
        { name = "luasnip", priority = 800 },   
      }, {
        { name = "buffer", priority = 700 },    
        { name = "path", priority = 600 },      
      }),
      
      -- ✅ CORRECTION: Ajouter Codeium dans les icônes et menus
      formatting = {
        format = function(entry, vim_item)
          local icons = {
            codeium = "🤖",     -- ✅ AJOUTÉ: Icône pour Codeium
            nvim_lsp = "🔧",
            luasnip = "🚀",
            buffer = "📄",
            path = "📁",
          }
          
          vim_item.kind = string.format("%s %s", icons[entry.source.name] or "❓", vim_item.kind)
          vim_item.menu = ({
            codeium = "[AI]",   -- ✅ AJOUTÉ: Menu pour Codeium
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
          })[entry.source.name]
          
          return vim_item
        end,
      },
      
      -- ✅ AJOUTÉ: Tri intelligent pour mettre Codeium en priorité
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })
    
    -- Configuration pour la recherche
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    
    -- Configuration pour la ligne de commande
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
    
    -- ✅ AJOUTÉ: Couleur personnalisée pour Codeium
    vim.api.nvim_set_hl(0, "CmpItemKindCodeium", { fg = "#6CC644", bold = true })
  end,
}

-- =============================================================================
-- VÉRIFICATIONS À FAIRE
-- =============================================================================

-- 1. Assure-toi d'avoir ces fichiers :
-- ~/.config/nvim/lua/plugins/codeium.lua (le fichier Exafunction/codeium.nvim)
-- ~/.config/nvim/lua/plugins/cmp-codeium.lua (le fichier jcdickinson/codeium.nvim)

-- 2. Dans Neovim, vérifie que les plugins sont installés :
-- :Lazy
-- Tu devrais voir "codeium.nvim" (les deux versions)

-- 3. Vérifie l'authentification :
-- :Codeium Auth

-- 4. Test :
-- Ouvre un fichier .lua ou .py
-- Commence à taper du code
-- Le menu cmp devrait s'ouvrir avec 🤖 [AI] en haut

-- =============================================================================
-- DEBUG - Si Codeium n'apparaît pas dans CMP
-- =============================================================================

-- Ajoute cette fonction de debug dans ton cmp.lua :
--[[
vim.api.nvim_create_autocmd("User", {
  pattern = "CmpReady",
  callback = function()
    print("Sources CMP disponibles:")
    for _, source in pairs(require("cmp").core.sources) do
      print("- " .. source.name)
    end
  end
})
--]]

-- =============================================================================
-- COMMANDES DE TEST
-- =============================================================================

-- Dans Neovim, tu peux tester avec ces commandes :
-- :lua print(vim.inspect(require("cmp").get_config().sources))
-- :CmpStatus  (si disponible)

-- =============================================================================
-- SI PROBLÈME PERSISTE - VERSION FORCÉE
-- =============================================================================

-- Si Codeium n'apparaît toujours pas, ajoute cette ligne après cmp.setup :
--[[
-- Forcer l'ajout de Codeium
vim.defer_fn(function()
  local cmp = require("cmp")
  local sources = cmp.get_config().sources or {}
  table.insert(sources, 1, { name = "codeium" })
  cmp.setup({ sources = sources })
end, 1000)
--]]
