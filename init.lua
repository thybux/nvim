#vim.api.nvim_set_keymap("i", "<C-b>", "[", { noremap = true, silent = true })
-- Remplacer '<M-S-b>' par la séquence correcte pour 'Option + Shift + B' selon votre terminal
vim.api.nvim_set_keymap('i', '<M-S-b>', '[', {noremap = true, silent = true})



-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

