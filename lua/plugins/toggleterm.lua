return {
  {
    "akinsho/toggleterm.nvim",
    configuration = true,
    cmd = "ToggleTerm",
    build = ":ToggleTerm",
    keys = { { "<F4>", "<cmd>ToggleTerm<cr>", desc = "Basculer le terminal flottant" } },
    opts = {
      open_mapping = [[<F4>]],
      shade_filetypes = {},
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
    },
  },
}
