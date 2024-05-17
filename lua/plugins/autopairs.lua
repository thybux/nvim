require('nvim-autopairs').setup {
    check_ts = true,
    ts_config = {
        lua = {'string'},  -- Désactive autopairs dans les chaînes Lua
        javascript = {'template_string'},
        java = false,
    },
    disable_filetype = { "TelescopePrompt", "vim" },
    fast_wrap = {},
}

