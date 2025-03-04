-- Dracula No Background Colorscheme for Neovim
-- Save this file as ~/.config/nvim/lua/dracula_no_bg.lua

local dracula_no_bg = function()
	-- Palette Dracula originale
	local fg = "#f8f8f2" -- Texte principal
	local comment = "#6272a4" -- Commentaires
	local selection = "#44475a" -- Sélection
	local cyan = "#8be9fd" -- Cyan
	local green = "#50fa7b" -- Vert
	local orange = "#ffb86c" -- Orange
	local pink = "#ff79c6" -- Rose
	local purple = "#bd93f9" -- Violet
	local red = "#ff5555" -- Rouge
	local yellow = "#f1fa8c" -- Jaune

	-- Reset toutes les couleurs de fond pour qu'elles soient transparentes
	vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
	vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
	vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")
	vim.cmd("highlight CursorLineNr guibg=NONE ctermbg=NONE")
	vim.cmd("highlight VertSplit guibg=NONE ctermbg=NONE")
	vim.cmd("highlight StatusLine guibg=NONE ctermbg=NONE")
	vim.cmd("highlight StatusLineNC guibg=NONE ctermbg=NONE")
	vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")

	-- Éléments de base
	vim.cmd("highlight Normal guifg=" .. fg)
	vim.cmd("highlight Comment guifg=" .. comment .. " gui=italic")

	-- Curseur et ligne active
	vim.cmd("highlight Cursor guifg=NONE guibg=" .. fg)
	vim.cmd("highlight CursorLine guibg=" .. selection .. " ctermbg=NONE")
	vim.cmd("highlight CursorLineNr guifg=" .. yellow .. " gui=bold")

	-- Sélection et recherche
	vim.cmd("highlight Visual guibg=" .. selection)
	vim.cmd("highlight Search guibg=" .. orange .. " guifg=#000000")
	vim.cmd("highlight IncSearch guibg=" .. green .. " guifg=#000000")

	-- Mots-clés et contrôle de flux
	vim.cmd("highlight Keyword guifg=" .. pink)
	vim.cmd("highlight Statement guifg=" .. pink)
	vim.cmd("highlight Conditional guifg=" .. pink)
	vim.cmd("highlight Repeat guifg=" .. pink)
	vim.cmd("highlight Label guifg=" .. pink)
	vim.cmd("highlight Exception guifg=" .. pink)

	-- Types et structures
	vim.cmd("highlight Type guifg=" .. cyan .. " gui=italic")
	vim.cmd("highlight StorageClass guifg=" .. pink)
	vim.cmd("highlight Structure guifg=" .. cyan)
	vim.cmd("highlight Typedef guifg=" .. cyan)

	-- Fonctions et variables
	vim.cmd("highlight Function guifg=" .. green .. " gui=bold")
	vim.cmd("highlight Identifier guifg=" .. cyan .. " gui=italic")

	-- Constantes et littéraux
	vim.cmd("highlight Constant guifg=" .. purple)
	vim.cmd("highlight String guifg=" .. yellow)
	vim.cmd("highlight Character guifg=" .. yellow)
	vim.cmd("highlight Number guifg=" .. purple)
	vim.cmd("highlight Boolean guifg=" .. purple)
	vim.cmd("highlight Float guifg=" .. purple)

	-- Préprocesseur
	vim.cmd("highlight PreProc guifg=" .. pink)
	vim.cmd("highlight Include guifg=" .. pink)
	vim.cmd("highlight Define guifg=" .. pink)
	vim.cmd("highlight Macro guifg=" .. pink)
	vim.cmd("highlight PreCondit guifg=" .. pink)

	-- Opérateurs et spéciaux
	vim.cmd("highlight Operator guifg=" .. pink)
	vim.cmd("highlight Special guifg=" .. pink)
	vim.cmd("highlight SpecialChar guifg=" .. pink)
	vim.cmd("highlight Tag guifg=" .. pink)
	vim.cmd("highlight Delimiter guifg=" .. fg)
	vim.cmd("highlight SpecialComment guifg=" .. comment .. " gui=bold")
	vim.cmd("highlight Debug guifg=" .. pink)

	-- PHP spécifique
	vim.cmd("highlight phpVarSelector guifg=" .. pink)
	vim.cmd("highlight phpVariable guifg=" .. orange)
	vim.cmd("highlight phpIdentifier guifg=" .. orange)
	vim.cmd("highlight phpType guifg=" .. cyan)
	vim.cmd("highlight phpFunction guifg=" .. green .. " gui=bold")
	vim.cmd("highlight phpMethod guifg=" .. green .. " gui=bold")
	vim.cmd("highlight phpClass guifg=" .. cyan .. " gui=italic")
	vim.cmd("highlight phpDocTags guifg=" .. comment .. " gui=bold")
	vim.cmd("highlight phpDocParam guifg=" .. comment)
	vim.cmd("highlight phpMemberSelector guifg=" .. fg)
	vim.cmd("highlight phpOperator guifg=" .. pink)
	vim.cmd("highlight phpStaticClasses guifg=" .. cyan .. " gui=italic")
	vim.cmd("highlight phpStringDouble guifg=" .. yellow)
	vim.cmd("highlight phpStringSingle guifg=" .. yellow)
	vim.cmd("highlight phpKeyword guifg=" .. pink)
	vim.cmd("highlight phpSqlKeyword guifg=" .. pink)
	vim.cmd("highlight phpSqlString guifg=" .. yellow)

	-- Messages et erreurs
	vim.cmd("highlight Error guifg=" .. red .. " gui=bold")
	vim.cmd("highlight ErrorMsg guifg=" .. red .. " gui=bold")
	vim.cmd("highlight WarningMsg guifg=" .. orange .. " gui=bold")
	vim.cmd("highlight Todo guifg=#000000 guibg=" .. yellow .. " gui=bold")

	-- Interface utilisateur
	vim.cmd("highlight Pmenu guibg=" .. selection)
	vim.cmd("highlight PmenuSel guibg=#6c71c4 guifg=" .. fg)
	vim.cmd("highlight LineNr guifg=" .. comment)
	vim.cmd("highlight NonText guifg=" .. comment)
	vim.cmd("highlight VertSplit guifg=" .. comment)
	vim.cmd("highlight MatchParen guibg=NONE guifg=" .. pink .. " gui=underline,bold")

	-- Diff
	vim.cmd("highlight DiffAdd guifg=" .. green .. " gui=bold")
	vim.cmd("highlight DiffChange guifg=" .. orange .. " gui=bold")
	vim.cmd("highlight DiffDelete guifg=" .. red .. " gui=bold")
	vim.cmd("highlight DiffText guifg=" .. cyan .. " gui=bold")
end

-- Appliquer le thème
dracula_no_bg()

-- Ajouter cette ligne à votre init.lua pour utiliser ce thème :
-- require('dracula_no_bg')
