local M = {}

-- Fonction pour identifier le type de fenêtre actuelle
local function get_window_type()
  local current_buf = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(current_buf, 'filetype')

  if filetype == 'neo-tree' then
    return 'neotree'
  elseif filetype == 'toggleterm' then
    return 'toggleterm'
  else
    return 'editor'
  end
end

-- Fonction pour vérifier si Neo-tree est ouvert
local function is_neotree_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
    if filetype == 'neo-tree' then
      return true, win
    end
  end
  return false, nil
end

-- Fonction pour vérifier si ToggleTerm est ouvert
local function is_toggleterm_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
    if filetype == 'toggleterm' then
      return true, win
    end
  end
  return false, nil
end

-- Fonction pour trouver la fenêtre éditeur
local function find_editor_window()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
    if filetype ~= 'neo-tree' and filetype ~= 'toggleterm' then
      return win
    end
  end
  return nil
end

-- Fonction pour obtenir les fenêtres disponibles
local function get_available_windows()
  local neotree_open, neotree_win = is_neotree_open()
  local toggleterm_open, toggleterm_win = is_toggleterm_open()
  local editor_win = find_editor_window()
  
  return {
    neotree = { open = neotree_open, window = neotree_win },
    toggleterm = { open = toggleterm_open, window = toggleterm_win },
    editor = { open = editor_win ~= nil, window = editor_win }
  }
end

-- Fonction principale de cycle AMÉLIORÉE
M.cycle_windows = function()
  local current_type = get_window_type()
  local windows = get_available_windows()
  
  -- Créer la liste des destinations possibles selon l'état actuel
  local cycle_order = {}
  
  -- Toujours inclure l'éditeur s'il existe
  if windows.editor.open then
    table.insert(cycle_order, { type = 'editor', window = windows.editor.window, name = "📝 Éditeur" })
  end
  
  -- Inclure Neo-tree s'il est ouvert
  if windows.neotree.open then
    table.insert(cycle_order, { type = 'neotree', window = windows.neotree.window, name = "📁 Neo-tree" })
  end
  
  -- Inclure ToggleTerm s'il est ouvert
  if windows.toggleterm.open then
    table.insert(cycle_order, { type = 'toggleterm', window = windows.toggleterm.window, name = "💻 Terminal" })
  end
  
  -- Si aucune fenêtre n'est disponible pour le cycle, créer une stratégie par défaut
  if #cycle_order == 0 then
    print("❌ Aucune fenêtre disponible")
    return
  end
  
  -- Si on a qu'une seule fenêtre, pas de cycle possible
  if #cycle_order == 1 then
    if current_type == 'editor' then
      -- Depuis l'éditeur, ouvrir Neo-tree
      vim.cmd("Neotree show")
      print("📁 Neo-tree (ouvert)")
    elseif current_type == 'neotree' then
      -- Depuis Neo-tree, ouvrir le terminal
      vim.cmd("ToggleTerm")
      print("💻 Terminal (ouvert)")
    else
      -- Depuis le terminal, aller à l'éditeur
      if windows.editor.open then
        vim.api.nvim_set_current_win(windows.editor.window)
        print("📝 Éditeur")
      else
        print("❌ Aucune fenêtre éditeur trouvée")
      end
    end
    return
  end
  
  -- Trouver la position actuelle dans le cycle
  local current_index = 1
  for i, win_info in ipairs(cycle_order) do
    if win_info.type == current_type then
      current_index = i
      break
    end
  end
  
  -- Calculer la prochaine position
  local next_index = current_index + 1
  if next_index > #cycle_order then
    next_index = 1
  end
  
  -- Aller à la prochaine fenêtre
  local next_window = cycle_order[next_index]
  if next_window.window then
    vim.api.nvim_set_current_win(next_window.window)
    print(next_window.name)
  end
end

-- Fonction intelligente pour aller à Neo-tree
M.goto_neotree = function()
  local neotree_open, neotree_win = is_neotree_open()
  if neotree_open and neotree_win then
    vim.api.nvim_set_current_win(neotree_win)
    print("📁 Neo-tree")
  else
    vim.cmd("Neotree show")
    print("📁 Neo-tree (ouvert)")
  end
end

-- Fonction intelligente pour aller à l'éditeur
M.goto_editor = function()
  local editor_win = find_editor_window()
  if editor_win then
    vim.api.nvim_set_current_win(editor_win)
    print("📝 Éditeur")
  else
    -- Créer un nouveau buffer si aucun éditeur n'est disponible
    vim.cmd("enew")
    print("📝 Nouvel éditeur")
  end
end

-- Fonction intelligente pour aller au terminal
M.goto_terminal = function()
  local toggleterm_open, toggleterm_win = is_toggleterm_open()
  if toggleterm_open and toggleterm_win then
    vim.api.nvim_set_current_win(toggleterm_win)
    print("💻 Terminal")
  else
    vim.cmd("ToggleTerm")
    print("💻 Terminal (ouvert)")
  end
end

-- Fonction pour afficher l'état des fenêtres (debug)
M.show_window_status = function()
  local windows = get_available_windows()
  print("État des fenêtres :")
  print("📁 Neo-tree: " .. (windows.neotree.open and "✅ ouvert" or "❌ fermé"))
  print("📝 Éditeur: " .. (windows.editor.open and "✅ ouvert" or "❌ fermé"))
  print("💻 Terminal: " .. (windows.toggleterm.open and "✅ ouvert" or "❌ fermé"))
  print("Fenêtre actuelle: " .. get_window_type())
end

return M
