return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      -- Formatters par langage
      formatters_by_ft = {
        -- Web Development
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        handlebars = { "prettier" },

        -- Python
        python = { "isort", "black" },

        -- Lua
        lua = { "stylua" },

        -- Go
        go = { "goimports", "gofmt" },

        -- Rust
        rust = { "rustfmt" },

        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },

        -- Java
        java = { "google-java-format" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },

        -- XML
        xml = { "xmlformat" },

        -- SQL
        sql = { "sqlformat" },

        -- TOML
        toml = { "taplo" },

        -- Nix
        nix = { "nixfmt" },

        -- Dart/Flutter
        dart = { "dart_format" },

        -- PHP
        php = { "php_cs_fixer" },

        -- Ruby
        ruby = { "rubocop" },

        -- Elixir
        elixir = { "mix" },

        -- Zig
        zig = { "zigfmt" },

        -- Fallback pour fichiers non reconnus
        ["_"] = { "trim_whitespace" },
      },

      -- Configuration des formatters
      formatters = {
        -- Prettier avec configuration custom
        prettier = {
          prepend_args = {
            "--single-quote",
            "--jsx-single-quote",
            "--trailing-comma",
            "es5",
            "--semi",
            "--tab-width",
            "2",
            "--print-width",
            "100",
          },
        },

        -- Black pour Python
        black = {
          prepend_args = {
            "--fast",
            "--line-length",
            "88",
          },
        },

        -- Stylua pour Lua
        stylua = {
          prepend_args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            "2",
            "--column-width",
            "100",
          },
        },

        -- Clang-format pour C/C++
        clang_format = {
          prepend_args = {
            "--style",
            "Google",
          },
        },

        -- shfmt pour scripts shell
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },

      -- Format automatique au save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },

      -- Format après timeout en mode insertion
      format_after_save = {
        lsp_fallback = true,
      },

      -- Notification en cas d'erreur
      notify_on_error = true,

      -- Log level
      log_level = vim.log.levels.ERROR,
    })

    -- Commande pour formater manuellement
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, range = range })
    end, { range = true })
  end,
}
