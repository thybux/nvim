-- Dans votre fichier keymaps.lua
local function smart_window_cycle()
	local current_win = vim.api.nvim_get_current_win()
	local windows = vim.api.nvim_list_wins()

	-- Filtrer les fenêtres valides (pas les popups/floating)
	local valid_windows = {}
	for _, win in ipairs(windows) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative == "" then -- Fenêtre normale (pas floating)
			table.insert(valid_windows, win)
		end
	end

	if #valid_windows <= 1 then
		return -- Une seule fenêtre, rien à faire
	end

	-- Trouver l'index de la fenêtre actuelle
	local current_index = 1
	for i, win in ipairs(valid_windows) do
		if win == current_win then
			current_index = i
			break
		end
	end

	-- Aller à la fenêtre suivante (cycle)
	local next_index = current_index + 1
	if next_index > #valid_windows then
		next_index = 1
	end

	vim.api.nvim_set_current_win(valid_windows[next_index])
end

-- Mapping
vim.keymap.set("n", "<leader><Tab>", smart_window_cycle, {
	desc = "Cycle entre les fenêtres (nvim-tree, éditeur, etc.)",
	silent = true,
})
