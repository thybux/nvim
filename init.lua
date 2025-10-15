-----------------------------------------------------------
-- init.lua — 100% monofichier
-- JS/TS + Go (optionnel), LSP, Treesitter, Telescope,
-- Git, Tests, Debug, Format (toggle), Copilot, jb.nvim,
-- et arborescence via neo-tree.
-----------------------------------------------------------

-- 0) Leaders AVANT tout
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- (option) masquer l'avertissement lspconfig deprecated (Nvim 0.11+)
local _notify = vim.notify
vim.notify = function(msg, level, opts)
  if type(msg) == "string" and msg:find("lspconfig") and msg:find("deprecated") then return end
  _notify(msg, level, opts)
end

-- 1) Options de base
local o = vim.opt
o.termguicolors = true
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true
o.swapfile = false
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.updatetime = 250
o.timeoutlen = 400
o.splitright = true
o.splitbelow = true
o.scrolloff = 6
o.list = true
o.listchars = "tab:» ,trail:·,extends:…,precedes:…"

-- pas d’auto-format à l’enregistrement par défaut (toggle plus bas)
vim.g.format_on_save = false

-- 2) Keymaps de base
local map = vim.keymap.set
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })

-- 3) Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Helpers
local function has(bin) return vim.fn.executable(bin) == 1 end
local function mason_installed(pkg)
  local ok, registry = pcall(require, "mason-registry")
  if not ok then return false end
  local ok2, p = pcall(registry.get_package, pkg)
  return ok2 and p:is_installed()
end

-- 4) Plugins
require("lazy").setup({
  -- Core/UI
  { "nvim-lua/plenary.nvim", lazy = true },
  { "akinsho/bufferline.nvim", event = "VeryLazy", opts = {} },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  { "folke/todo-comments.nvim", event = "VeryLazy", opts = {} },
  { "folke/trouble.nvim", cmd = "Trouble", opts = {} },

  -- Thème JetBrains : jb.nvim + lualine thème 'jb'
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = { options = { theme = "jb", globalstatus = true } }, -- thème fourni par jb.nvim
  },
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    opts = {}, -- ex: { transparent = true }
    config = function(_, opts)
      require("jb").setup(opts)
      vim.cmd("colorscheme jb")
    end,
  }, --  [oai_citation:2‡GitHub](https://github.com/nickkadutskyi/jb.nvim)

  -- Arborescence (sidebar) : neo-tree (branche v3.x)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Explorer (neo-tree)" })
      map("n", "<leader>o", "<cmd>Neotree focus<cr>",  { desc = "Focus explorer" })
    end,
    opts = {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        indent = { with_markers = true },
        modified = { symbol = "●" },
        git_status = { symbols = { added = "A", modified = "M", deleted = "D", renamed = "R" } },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = { visible = false, hide_dotfiles = false, hide_gitignored = true },
      },
      window = { width = 32, mappings = { ["<space>"] = "none" } },
    },
  }, --  [oai_citation:3‡GitHub](https://github.com/nvim-neo-tree/neo-tree.nvim)

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    init = function()
      map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",  { desc = "Live grep" })
      map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",    { desc = "Buffers" })
      map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",  { desc = "Help" })
    end,
    opts = function()
      local actions = require("telescope.actions")
      return {
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      }
    end,
  },

  { "echasnovski/mini.surround", version = false, config = true },

  { 
	  "folke/flash.nvim", event = "VeryLazy", opts = {}, keys = {
  { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
  { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
}, },

  -- harpoon permet une navigation ultra rapide entre les fichiers
  { "ThePrimeagen/harpoon", branch = "harpoon2", dependencies = { "nvim-lua/plenary.nvim" },
	  config = function()
	    local harpoon = require("harpoon")
	    harpoon:setup()

	    map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add file" })
	    map("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

	    map("n", "<leader>1", function() harpoon:list():select(1) end)
	    map("n", "<leader>2", function() harpoon:list():select(2) end)
	    map("n", "<leader>3", function() harpoon:list():select(3) end)
	    map("n", "<leader>4", function() harpoon:list():select(4) end)
	  end
	},
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua","vim","vimdoc","regex","bash","markdown","json","yaml",
        "tsx","typescript","javascript"-- "go","gomod"
      },
      highlight = { enable = true },
      indent = { enable = true },
    }
  },

  -- Git
  { "lewis6991/gitsigns.nvim", event = "BufReadPre", opts = {} },
  { "NeogitOrg/neogit", cmd = "Neogit", opts = {}, init = function()
      map("n","<leader>gs","<cmd>Neogit kind=tab<cr>",{desc="Neogit"})
    end
  },

  -- Completion (cmp + luasnip)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
          -- Copilot sera injecté plus bas si présent
        }),
        formatting = {
          format = function(entry, item)
            item.menu = ({ nvim_lsp="[LSP]", buffer="[Buf]", path="[Path]", luasnip="[Snip]", copilot="[AI]" })[entry.source.name]
            return item
          end
        },
        window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
      })
    end,
  },

  -- LSP (Mason + lspconfig; Go conditionnel)
  { "williamboman/mason.nvim", build = ":MasonUpdate", opts = { ui = { border = "rounded" } } },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- ensure_installed = { "vtsls", "eslint", "gopls", "lua_ls" },
      ensure_installed = { "vtsls", "eslint", "lua_ls" },
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- TS/JS via vtsls
      lspconfig.vtsls.setup({
        capabilities = capabilities,
        settings = {
          typescript = { format = { enable = false } },
          javascript = { format = { enable = false } },
        },
      })

      -- ESLint (diagnostics + fixes ; pas de format)
      lspconfig.eslint.setup({
        capabilities = capabilities,
        settings = { workingDirectories = { mode = "auto" }, format = false, experimental = { useFlatConfig = true } },
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = { Lua = { diagnostics = { globals = { "vim" } } } },
      })

      -- Go (seulement si gopls dispo)
      if mason_installed("gopls") or has("gopls") then
        lspconfig.gopls.setup({
          capabilities = capabilities,
          settings = { gopls = { gofumpt = true, usePlaceholders = true, analyses = { unusedparams = true, unreachable = true } } }
        })
      end

      -- Keymaps LSP + diagnostics UI
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      map("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
      map("n", "K",  vim.lsp.buf.hover, { desc = "Hover" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
      map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        severity_sort = true,
        float = { border = "rounded" },
      })
    end
  },

  -- Format (off by default; toggle <leader>tf)
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", "biome" },
        typescript = { "prettierd", "prettier", "biome" },
        javascriptreact = { "prettierd", "prettier", "biome" },
        typescriptreact = { "prettierd", "prettier", "biome" },
        json = { "biome", "jq", "prettier" },
        yaml = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        go = { "gofumpt", "goimports-reviser", "golines" },
        lua = { "stylua" },
      },
    },
    init = function()
      map("n", "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format" })
      map("n", "<leader>tf", function()
        vim.g.format_on_save = not vim.g.format_on_save
        vim.notify("Format on save: " .. (vim.g.format_on_save and "ON" or "OFF"))
      end, { desc = "Toggle format on save" })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
        callback = function(args)
          if vim.g.format_on_save then
            require("conform").format({ bufnr = args.buf, lsp_fallback = true })
          end
        end,
      })
    end
  },

  -- Go utils (chargés seulement si 'go' existe)
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod", "gowork", "gotmpl" },
    cond = function() return has("go") end,
    dependencies = { "ray-x/guihua.lua" },
    opts = { diagnostic = { hdlr = true }, lsp_cfg = false, trouble = true },
    config = function(_, opts)
      require("go").setup(opts)
      map("n", "<leader>gi", "<cmd>GoImpl<cr>", { desc = "Go implement interface" })
      map("n", "<leader>ga", "<cmd>GoAddTag<cr>", { desc = "Go add tags" })
    end,
  },

  -- DAP (debug) + UI + Mason auto (js/go conditionnels)
  { "mfussenegger/nvim-dap", lazy = true },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true, dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui"]      = function() dapui.close() end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = function()
      local ensure = {}
      if has("node") then table.insert(ensure, "js") end
      if has("go")   then table.insert(ensure, "delve") end
      return { ensure_installed = ensure, automatic_installation = true }
    end,
  },

  -- Tests (neotest) — nvim-nio requis, neotest-go si Go dispo
  {
    "nvim-neotest/neotest",
    dependencies = (function()
      local deps = { "nvim-lua/plenary.nvim", "haydenmeade/neotest-jest", "nvim-neotest/nvim-nio" }
      if has("go") then table.insert(deps, "nvim-neotest/neotest-go") end
      return deps
    end)(),
    init = function()
      map("n", "<leader>tt", function() require("neotest").run.run() end, { desc = "Test nearest" })
      map("n", "<leader>tF", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Test file" })
      map("n", "<leader>to", function() require("neotest").output.open({ enter = true }) end, { desc = "Test output" })
    end,
    config = function()
      local adapters = {}
      if has("go") then table.insert(adapters, require("neotest-go")({ experimental = { test_table = true } })) end
      table.insert(adapters, require("neotest-jest")({ jestCommand = "npm test --", env = { CI = true } }))
      require("neotest").setup({ adapters = adapters })
    end,
  },

  -- IA: Copilot (ghost text, sans chat)
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = { suggestion = { enabled = true, auto_trigger = true }, panel = { enabled = false } },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      local ok, cmp = pcall(require, "cmp")
      if not ok then return end
      require("copilot_cmp").setup()
      local cfg = cmp.get_config()
      cfg.sources = cmp.config.sources({ { name = "copilot" } }, cfg.sources)
      cmp.setup(cfg)
    end
  },

}, { ui = { border = "rounded" }, change_detection = { notify = false } })

-- Raccourcis restants
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })


-----------------------------------------------------------
-- 🔁  Navigation améliorée : buffers + fenêtres/neo-tree
-----------------------------------------------------------

-- 1️⃣  Navigation entre buffers (Tab / Shift+Tab)
--   - seulement en mode NORMAL
--   - <Tab> = buffer suivant, <S-Tab> = buffer précédent
map("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, desc = "Buffer suivant" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, desc = "Buffer précédent" })

-- 2️⃣  Rotation du focus entre fenêtres et arborescence (leader+Tab)
local function cycle_windows()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  if #wins <= 1 then return end

  local current_win = vim.api.nvim_get_current_win()
  local next_win
  local found_current = false

  -- cherche la fenêtre suivante dans la liste
  for _, w in ipairs(wins) do
    if found_current then
      next_win = w
      break
    end
    if w == current_win then
      found_current = true
    end
  end
  -- si on est à la fin, boucle sur la première
  if not next_win then next_win = wins[1] end

  vim.api.nvim_set_current_win(next_win)
end

-- 3️⃣  Détection spéciale pour inclure/exclure la fenêtre Neo-tree
--     (si l'arborescence n'est pas ouverte, la rotation ne change rien)
map("n", "<leader><Tab>", function()
  -- récupère toutes les fenêtres visibles
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local valid_wins = {}
  local has_neotree = false

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "neo-tree" then
      has_neotree = true
    end
    table.insert(valid_wins, win)
  end

  if #valid_wins <= 1 then
    return -- rien à faire
  end

  -- si neo-tree est ouvert, on fait une rotation simple
  if has_neotree then
    cycle_windows()
  else
    -- pas d'arborescence, même cycle classique
    cycle_windows()
  end
end, { silent = true, desc = "Cycle entre code et arborescence" })

-----------------------------------------------------------
-- 🧩 :Q comportement intelligent
-----------------------------------------------------------
vim.api.nvim_create_user_command("Qsmart", function()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  if #wins > 1 then
    -- si c'est Neo-tree, on le ferme juste
    local buf = vim.api.nvim_win_get_buf(0)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "neo-tree" then
      vim.cmd("Neotree close")
      return
    end
    -- sinon, ferme juste ce split
    vim.cmd("close")
  else
    -- dernière fenêtre → quitte Neovim
    vim.cmd("qall")
  end
end, { desc = "Quit intelligemment" })

-- remapper :q et <leader>q
vim.cmd([[cabbrev q Qsmart]])
map("n", "<leader>q", "<cmd>Qsmart<cr>", { desc = "Quit intelligently" })
