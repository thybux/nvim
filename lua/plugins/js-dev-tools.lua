-- Plugins de développement JS/TS avancés - désactivés temporairement
if true then return {} end

return {
  -- Outils de développement JavaScript/TypeScript avancés
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      -- Optimisations pour gros projets
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = {},
        tsserver_max_memory = 8192, -- 8GB pour gros projets
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        code_lens = "off", -- Désactivé pour performance
      },
    },
  },

  -- Debugging pour Node.js et navigateur
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mxsdev/nvim-dap-vscode-js",
    },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- Setup DAP UI
      dapui.setup()
      
      -- Setup virtual text
      require("nvim-dap-virtual-text").setup()
      
      -- Setup JS/TS debugging
      require("dap-vscode-js").setup({
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
      })
      
      -- Configuration pour Node.js
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require'dap.utils'.pick_process,
          cwd = "${workspaceFolder}",
        }
      }
      
      -- Même config pour TypeScript
      dap.configurations.typescript = dap.configurations.javascript
      
      -- Keymaps pour debugging
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Start/Continue Debugging' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Step Out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Condition: ')) end, { desc = 'Conditional Breakpoint' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle Debug UI' })
      
      -- Auto-open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Testing avec Jest/Vitest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-vitest")({
            vitestCommand = "npm run test",
          }),
        },
        discovery = {
          enabled = false, -- Désactivé pour performance sur gros projets
        },
        running = {
          concurrent = true,
        },
        summary = {
          open = "botright vsplit | vertical resize 50"
        }
      })
      
      -- Keymaps pour les tests
      vim.keymap.set('n', '<leader>tt', require("neotest").run.run, { desc = 'Run Test' })
      vim.keymap.set('n', '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = 'Run File Tests' })
      vim.keymap.set('n', '<leader>td', function() require("neotest").run.run({strategy = "dap"}) end, { desc = 'Debug Test' })
      vim.keymap.set('n', '<leader>ts', require("neotest").summary.toggle, { desc = 'Toggle Test Summary' })
      vim.keymap.set('n', '<leader>to', require("neotest").output.open, { desc = 'Open Test Output' })
    end,
  },

  -- Refactoring avancé
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require('refactoring').setup({})
      
      -- Keymaps pour refactoring
      vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Extract function" })
      vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ", { desc = "Extract to file" })
      vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Extract variable" })
      vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Inline variable" })
      vim.keymap.set("n", "<leader>rI", ":Refactor inline_func", { desc = "Inline function" })
      vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { desc = "Extract block" })
      vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file", { desc = "Extract block to file" })
    end,
  },

  -- Package.json et gestion des dépendances
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    config = function()
      require('package-info').setup({
        colors = {
          up_to_date = "#3C4048",
          outdated = "#fc514e",
        },
        icons = {
          enable = true,
          style = {
            up_to_date = "|  ",
            outdated = "|  ",
          },
        },
        autostart = true,
        hide_up_to_date = true,
        hide_unstable_versions = false,
      })
      
      -- Keymaps pour package.json
      vim.keymap.set('n', '<leader>ns', require('package-info').show, { desc = 'Show package versions', silent = true })
      vim.keymap.set('n', '<leader>nc', require('package-info').hide, { desc = 'Hide package versions', silent = true })
      vim.keymap.set('n', '<leader>nt', require('package-info').toggle, { desc = 'Toggle package versions', silent = true })
      vim.keymap.set('n', '<leader>nu', require('package-info').update, { desc = 'Update package', silent = true })
    end,
  },

  -- Import automatique et organisation
  {
    "stevanmilic/nvim-lspimport",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      -- Keymap pour import automatique
      vim.keymap.set('n', '<leader>im', require('lspimport').import, { desc = 'Auto import under cursor' })
    end,
  },

  -- Console.log rapide pour debugging
  {
    "gaelph/logsitter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require('logsitter').setup()
      
      -- Keymaps pour logging
      vim.keymap.set('n', '<leader>lg', require('logsitter').log, { desc = 'Add console.log' })
    end,
  },
}