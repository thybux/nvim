-- JetBrains New UI Inspired Colorscheme for Neovim
-- Save this file as a Lua module and source it in your init.lua
-- Example: require('jetbrains_ui_colors')

local custom_colorscheme = function()
	-- Background and foreground
	-- vim.cmd('highlight Normal guibg=#2b2d30 guifg=#dcdcdc')

	-- Comments
	vim.cmd("highlight Comment guifg=#808080 gui=italic")

	-- Brackets
	vim.cmd("highlight Bracket guifg=#dcdcdc")

	-- Variable types
	vim.cmd("highlight Type guifg=#ffcb6b")

	-- Add highlights for curly brackets
	vim.cmd("highlight Delimiter guifg=#c8c8c8")

	-- Keywords
	vim.cmd("highlight Keyword guifg=#c792ea")

	-- Functions
	vim.cmd("highlight Function guifg=#82aaff")

	-- Strings
	vim.cmd("highlight String guifg=#c3e88d")

	-- Variables
	vim.cmd("highlight Identifier guifg=#f78c6c")

	-- Numbers
	vim.cmd("highlight Number guifg=#ff5370")

	-- Visual mode selection
	vim.cmd("highlight Visual guibg=#3e4451")

	-- Error messages
	vim.cmd("highlight Error guifg=#ff5370")

	-- Line numbers
	vim.cmd("highlight LineNr guifg=#4b5263")

	-- Cursor line number
	vim.cmd("highlight CursorLineNr guifg=#ffffff")

	-- Status line
	vim.cmd("highlight StatusLine guibg=#21252b guifg=#dcdcdc")

	-- Match parenthesis
	vim.cmd("highlight MatchParen guibg=#3e4451 guifg=#ffffff gui=bold")

	-- Punctuation
	vim.cmd("highlight Punctuation guifg=#dcdcdc")

	-- Operators
	vim.cmd("highlight Operator guifg=#dcdcdc")

	-- Todo comments
	vim.cmd("highlight Todo guifg=#ffcb6b guibg=#2b2d30 gui=bold")

	-- Cursor
	vim.cmd("highlight Cursor guifg=#2b2d30 guibg=#82aaff")

	-- Tabs
	vim.cmd("highlight TabLine guibg=#2b2d30 guifg=#4b5263")
	vim.cmd("highlight TabLineSel guibg=#3e4451 guifg=#ffffff")
	vim.cmd("highlight TabLineFill guibg=#2b2d30")

	-- Popup menus
	vim.cmd("highlight Pmenu guibg=#3e4451 guifg=#dcdcdc")
	vim.cmd("highlight PmenuSel guibg=#4b5263 guifg=#ffffff")

	-- Search highlight
	vim.cmd("highlight Search guibg=#ffc107 guifg=#2b2d30")

	-- Diff colors
	vim.cmd("highlight DiffAdd guibg=#294436 guifg=#a3be8c")
	vim.cmd("highlight DiffChange guibg=#3e4451 guifg=#e0af68")
	vim.cmd("highlight DiffDelete guibg=#4b5263 guifg=#ff5370")
	vim.cmd("highlight DiffText guibg=#3c4048 guifg=#82aaff")
end

-- Apply the custom colorscheme
custom_colorscheme()
