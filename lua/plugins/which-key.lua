-- =============================================================================
-- ~/.config/nvim/lua/plugins/which-key.lua
-- Configuration Which-key v3 (nouvelle API sans warnings)
-- =============================================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")

    -- Configuration de base (nouvelle API)
    wk.setup({
      preset = "modern", -- ou "classic", "modern", "helix"
      delay = 300,
      expand = 1,
      notify = true,

      -- Configuration des icônes
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        mappings = true,
        rules = {},
        colors = true,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },

      -- Configuration de la fenêtre
      win = {
        border = "rounded",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        bo = {},
        wo = {},
      },

      layout = {
        width = { min = 20 },
        spacing = 3,
      },

      -- Déclencheurs
      triggers = {
        { "<auto>", mode = "nxsot" },
      },

      -- Filtres
      filter = function(mapping)
        return true
      end,

      spec = {
        -- =============================================================================
        -- MAPPINGS AVEC <leader>
        -- =============================================================================

        -- Fichiers et recherche
        { "<leader>f", group = "🔍 Find & Search" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
        { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
        { "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
        { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
        { "<leader>ft", "<cmd>Telescope colorscheme<cr>", desc = "Themes" },

        -- Explorer
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "🌳 Toggle Explorer" },

        -- Windows
        { "<leader>w", group = "🪟 Windows" },
        { "<leader>wh", "<C-w>h", desc = "Go Left" },
        { "<leader>wj", "<C-w>j", desc = "Go Down" },
        { "<leader>wk", "<C-w>k", desc = "Go Up" },
        { "<leader>wl", "<C-w>l", desc = "Go Right" },
        { "<leader>ws", "<C-w>s", desc = "Split Horizontal" },
        { "<leader>wv", "<C-w>v", desc = "Split Vertical" },
        { "<leader>wc", "<C-w>c", desc = "Close Window" },
        { "<leader>wo", "<C-w>o", desc = "Only Window" },
        { "<leader>w=", "<C-w>=", desc = "Balance Windows" },

        -- Codeium
        { "<leader>c", group = "🤖 Codeium AI" },
        { "<leader>ce", "<cmd>Codeium Enable<cr>", desc = "Enable Codeium" },
        { "<leader>cd", "<cmd>Codeium Disable<cr>", desc = "Disable Codeium" },
        { "<leader>ct", "<cmd>Codeium Toggle<cr>", desc = "Toggle Codeium" },
        { "<leader>cs", "<cmd>Codeium Auth<cr>", desc = "Setup/Auth Codeium" },
        { "<leader>ci", "<cmd>Codeium Chat<cr>", desc = "Codeium Chat" },

        -- Format & Code
        { "<leader>m", group = "🎨 Format & Code" },
        {
          "<leader>mp",
          function()
            require("conform").format({
              lsp_fallback = true,
              async = false,
              timeout_ms = 1000,
            })
          end,
          desc = "Format Code",
        },
        {
          "<leader>mf",
          function()
            require("conform").format({ lsp_fallback = true })
            vim.cmd("write")
          end,
          desc = "Format & Save",
        },
        {
          "<leader>mt",
          function()
            local conform = require("conform")
            if conform.will_fallback_lsp() then
              conform.setup({ format_on_save = false })
              print("🔴 Auto-format désactivé")
            else
              conform.setup({
                format_on_save = {
                  timeout_ms = 500,
                  lsp_fallback = true,
                },
              })
              print("🟢 Auto-format activé")
            end
          end,
          desc = "Toggle Auto-format",
        },
        { "<leader>mi", "<cmd>ConformInfo<cr>", desc = "Formatter Info" },
        { "<leader>ml", "<cmd>LspInfo<cr>", desc = "LSP Info" },
        { "<leader>mr", "<cmd>LspRestart<cr>", desc = "Restart LSP" },

        -- LSP & Diagnostics
        { "<leader>l", group = "🔧 LSP & Diagnostics" },
        { "<leader>ld", vim.lsp.buf.definition, desc = "Go to Definition" },
        { "<leader>lD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
        { "<leader>li", vim.lsp.buf.implementation, desc = "Go to Implementation" },
        { "<leader>lr", vim.lsp.buf.references, desc = "References" },
        { "<leader>lh", vim.lsp.buf.hover, desc = "Hover Documentation" },
        { "<leader>ls", vim.lsp.buf.signature_help, desc = "Signature Help" },
        { "<leader>ln", vim.lsp.buf.rename, desc = "Rename" },
        { "<leader>la", vim.lsp.buf.code_action, desc = "Code Actions" },
        {
          "<leader>lf",
          function()
            vim.lsp.buf.format({ async = true })
          end,
          desc = "Format",
        },
        { "<leader>le", vim.diagnostic.open_float, desc = "Show Diagnostics" },
        { "<leader>lq", vim.diagnostic.setloclist, desc = "Diagnostics to Location List" },
        { "<leader>l[", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
        { "<leader>l]", vim.diagnostic.goto_next, desc = "Next Diagnostic" },

        -- Terminal
        { "<leader>t", group = "💻 Terminal & System" },
        { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
        { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
        { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical Terminal" },

        -- Buffers
        { "<leader>b", group = "📄 Buffers" },
        { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
        { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
        { "<leader>bD", "<cmd>bdelete!<cr>", desc = "Force Delete Buffer" },
        { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
        { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
        { "<leader>bf", "<cmd>bfirst<cr>", desc = "First Buffer" },
        { "<leader>bl", "<cmd>blast<cr>", desc = "Last Buffer" },

        -- Git (préparé pour futur)
        { "<leader>g", group = "🌿 Git" },
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        { "<leader>gs", "<cmd>Gitsigns toggle_signs<cr>", desc = "Toggle Signs" },
        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Blame" },
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
        { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
        { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This" },

        -- Utils
        { "<leader>u", group = "🛠️ Utils" },
        { "<leader>uc", "<cmd>checkhealth<cr>", desc = "Check Health" },
        { "<leader>um", "<cmd>Mason<cr>", desc = "Mason" },
        { "<leader>ul", "<cmd>Lazy<cr>", desc = "Lazy" },
        { "<leader>ur", "<cmd>source %<cr>", desc = "Reload Config" },
        { "<leader>uq", "<cmd>qa<cr>", desc = "Quit All" },
        { "<leader>uw", "<cmd>wa<cr>", desc = "Save All" },

        -- Raccourcis spéciaux
        {
          "<leader><tab>",
          function()
            require("config.window-cycle").cycle_windows()
          end,
          desc = "🔄 Cycle Windows",
        },
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "❓ Buffer Keymaps",
        },
        { "<leader>pv", vim.cmd.Ex, desc = "📂 File Explorer" },

        -- =============================================================================
        -- MAPPINGS SANS <leader>
        -- =============================================================================

        -- Navigation
        { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Tab" },
        { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Tab" },

        -- LSP raccourcis directs
        { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
        { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
        { "gr", vim.lsp.buf.references, desc = "References" },
        { "gi", vim.lsp.buf.implementation, desc = "Implementation" },
        { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
        { "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
        { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },

        -- =============================================================================
        -- MAPPINGS EN MODE INSERTION
        -- =============================================================================

        {
          "<C-g>",
          function()
            return vim.fn["codeium#Accept"]()
          end,
          desc = "Accept Codeium",
          mode = "i",
          expr = true,
        },
        {
          "<C-;>",
          function()
            return vim.fn["codeium#CycleCompletions"](1)
          end,
          desc = "Next Codeium",
          mode = "i",
          expr = true,
        },
        {
          "<C-,>",
          function()
            return vim.fn["codeium#CycleCompletions"](-1)
          end,
          desc = "Prev Codeium",
          mode = "i",
          expr = true,
        },
        {
          "<C-x>",
          function()
            return vim.fn["codeium#Clear"]()
          end,
          desc = "Clear Codeium",
          mode = "i",
          expr = true,
        },

        -- =============================================================================
        -- MAPPINGS EN MODE VISUEL
        -- =============================================================================

        { "J", ":m '>+1<CR>gv=gv", desc = "Move selection down", mode = "v" },
        { "K", ":m '<-2<CR>gv=gv", desc = "Move selection up", mode = "v" },
        {
          "<leader>mp",
          function()
            require("conform").format({
              lsp_fallback = true,
              async = false,
              timeout_ms = 1000,
            })
          end,
          desc = "Format Selection",
          mode = "v",
        },
      },
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

-- =============================================================================
-- BONUS : INSTALLATION DE MINI.ICONS (POUR SUPPRIMER LE WARNING)
-- =============================================================================

-- Ajoute ce fichier si tu veux supprimer le warning "mini.icons is not installed"
-- ~/.config/nvim/lua/plugins/mini-icons.lua

--[[
return {
  "echasnovski/mini.icons",
  opts = {},
  lazy = true,
  specs = {
    { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
--]]

-- =============================================================================
-- NOTES IMPORTANTES
-- =============================================================================

-- 1. Cette configuration utilise la nouvelle API Which-key v3
-- 2. Plus de warnings sur les options dépréciées
-- 3. Structure plus claire avec spec = { ... }
-- 4. Tous tes raccourcis existants sont préservés
-- 5. Le warning "mini.icons" peut être ignoré ou résolu avec le plugin ci-dessus

-- =============================================================================
-- UTILISATION
-- =============================================================================

-- Après installation :
-- 1. Appuie sur <leader> → Menu organisé avec icônes
-- 2. <leader>f → Recherche et fichiers
-- 3. <leader>m → Formatage et code
-- 4. <leader>c → Codeium IA
-- 5. <leader>? → Raccourcis du buffer actuel

-- Tes raccourcis existants fonctionnent toujours :
-- - Tab/Shift+Tab pour bufferline
-- - <leader><tab> pour cycle windows
-- - Ctrl+G, Ctrl+; pour Codeium
-- - gd, gr, K pour LSP
