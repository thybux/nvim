-- =============================================================================
-- ~/.config/nvim/lua/plugins/lsp.lua
-- Configuration LSP complète et corrigée selon la documentation officielle
-- =============================================================================

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Configuration Mason-lspconfig
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls", -- Lua
        "pyright", -- Python
        "intelephense", -- PHP
      },
      -- Les LSP dans ensure_installed s'installent automatiquement
    })

    -- Configuration des handlers pour chaque LSP
    require("mason-lspconfig").setup_handlers({
      -- Handler par défaut pour tous les LSP
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- Configuration spécifique pour Lua
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
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
      end,

      -- Configuration spécifique pour PHP (Intelephense)
      ["intelephense"] = function()
        lspconfig.intelephense.setup({
          capabilities = capabilities,
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000,
                associations = { "*.php", "*.phtml" },
                exclude = {
                  "**/.git/**",
                  "**/node_modules/**",
                  "**/vendor/**/{Tests,tests}/**",
                  "**/.history/**",
                  "**/storage/**",
                  "**/bootstrap/cache/**",
                },
              },
              environment = {
                includePaths = { "vendor/" },
              },
              completion = {
                insertUseDeclaration = true,
                fullyQualifyGlobalConstantsAndFunctions = false,
                triggerParameterHints = true,
                maxItems = 100,
              },
              format = {
                enable = true,
              },
              diagnostics = {
                enable = true,
                run = "onType",
                embeddedLanguages = true,
              },
            },
          },
          on_attach = function(client, bufnr)
            print("🐘 PHP LSP (Intelephense) attaché au fichier " .. vim.fn.expand("%:t"))

            -- Keymaps spécifiques PHP
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set("n", "<leader>pu", function()
              vim.lsp.buf.code_action({
                filter = function(action)
                  return action.title:match("Import") or action.title:match("use")
                end,
                apply = true,
              })
            end, opts)
          end,
        })
      end,

      -- Configuration spécifique pour Python
      ["pyright"] = function()
        lspconfig.pyright.setup({
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
              },
            },
          },
        })
      end,
    })

    -- Keybindings LSP généraux
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf, silent = true }

        -- Navigation
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

        -- Documentation
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        -- Workspace
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        -- Édition
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        -- Diagnostics
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

        -- Refresh CodeLens
        if vim.lsp.buf.code_lens then
          vim.keymap.set("n", "<leader>cl", vim.lsp.buf.code_lens, opts)
        end

        print("🔧 LSP " .. ev.data.client_id .. " attaché au buffer " .. ev.buf)
      end,
    })

    -- Configuration des diagnostics
    vim.diagnostic.config({
      virtual_text = {
        enabled = true,
        source = "if_many",
        prefix = "●",
        -- Only show virtual text for errors
        severity = vim.diagnostic.severity.ERROR,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "✗",
          [vim.diagnostic.severity.WARN] = "⚠",
          [vim.diagnostic.severity.INFO] = "ℹ",
          [vim.diagnostic.severity.HINT] = "💡",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        format = function(diagnostic)
          return string.format("%s (%s)", diagnostic.message, diagnostic.source)
        end,
      },
    })

    -- LSP UI improvements
    local signs = {
      Error = "✗",
      Warn = "⚠",
      Info = "ℹ",
      Hint = "💡",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Configure LSP handlers
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
      width = 60,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
      width = 60,
    })

    -- Custom commands
    vim.api.nvim_create_user_command("LspRestart", function()
      vim.cmd("LspStop")
      vim.defer_fn(function()
        vim.cmd("LspStart")
      end, 500)
    end, {})

    vim.api.nvim_create_user_command("LspLog", function()
      vim.cmd("edit " .. vim.lsp.get_log_path())
    end, {})

    vim.api.nvim_create_user_command("LspInfo", function()
      vim.cmd("LspInfo")
    end, {})
  end,
}
