-- mel-desert
-- created on https://nvimcolors.com

-- Clear existing highlights and reset syntax
vim.cmd('highlight clear')
vim.cmd('syntax reset')

-- Basic UI elements
vim.cmd('highlight Normal guibg=#181818 guifg=#ffffff')
vim.cmd('highlight NormalFloat guibg=none guifg=#ffffff')
vim.cmd('highlight NonText guibg=#181818 guifg=#181818')
vim.cmd('highlight CursorLine guibg=#2f2f2f')
vim.cmd('highlight LineNr guifg=#585858')
vim.cmd('highlight CursorLineNr guifg=#eeee00')
vim.cmd('highlight SignColumn guibg=#181818')
vim.cmd('highlight StatusLine guibg=#2f2f2f guifg=#ffffff')
vim.cmd('highlight StatusLineNC guibg=#2f2f2f guifg=#242424')
vim.cmd('highlight Directory guifg=#33ffff')
vim.cmd('highlight Visual guibg=#4d4d4d')
vim.cmd('highlight Search guibg=#8c8c8c guifg=#f9f06b')
vim.cmd('highlight CurSearch guibg=#e5a50a guifg=#181818')
vim.cmd('highlight IncSearch gui=None guibg=#e5a50a guifg=#181818')
vim.cmd('highlight MatchParen guibg=#8c8c8c guifg=#f9f06b')
vim.cmd('highlight Pmenu guibg=#464646 guifg=#ffffff')
vim.cmd('highlight PmenuSel guibg=#e5a50a guifg=#181818')
vim.cmd('highlight PmenuSbar guibg=#7e7e7e guifg=#ffffff')
vim.cmd('highlight VertSplit guifg=#545454')
vim.cmd('highlight MoreMsg guifg=#ffa0a0')
vim.cmd('highlight Question guifg=#ffa0a0')
vim.cmd('highlight Title guifg=#ffffff')

-- Syntax highlighting
vim.cmd('highlight Comment guifg=#8c8c8c')
-- vim.cmd('highlight Comment guifg=#6dceeb')
vim.cmd('highlight Constant guifg=#ffa0a0')
vim.cmd('highlight Identifier guifg=#ffffff')
vim.cmd('highlight Statement guifg=#f0e68c guibg=NONE gui=bold cterm=bold')
vim.cmd('highlight PreProc guifg=#bdb76b guibg=NONE')
vim.cmd('highlight Type guifg=#bdb76b guibg=NONE gui=bold cterm=bold')
vim.cmd('highlight Special guifg=#a0eeee')

-- Refined syntax highlighting
vim.cmd('highlight String guifg=#ffa0a0')
-- vim.cmd('highlight String guifg=#60cc60')
vim.cmd('highlight Number guifg=#ffffff')
vim.cmd('highlight Boolean guifg=#ffa0a0')
vim.cmd('highlight Function guifg=#ffffff')
-- vim.cmd('highlight Keyword guifg=#c2bfa5')
vim.cmd('highlight Keyword guifg=#f0e68c')

-- Html syntax highlighting
vim.cmd('highlight Tag guifg=#eeee00')
vim.cmd('highlight @tag.delimiter guifg=#ffa0a0')
vim.cmd('highlight @tag.attribute guifg=#ffffff')

-- Messages
vim.cmd('highlight ErrorMsg guifg=#ff0000')
vim.cmd('highlight Error guifg=#ff0000')
vim.cmd('highlight DiagnosticError guifg=#ff0000')
vim.cmd('highlight DiagnosticVirtualTextError guibg=#2f1616 guifg=#ff0000')
vim.cmd('highlight WarningMsg guifg=#ffcc00')
vim.cmd('highlight DiagnosticWarn guifg=#ffcc00')
vim.cmd('highlight DiagnosticVirtualTextWarn guibg=#2f2a16 guifg=#ffcc00')
vim.cmd('highlight DiagnosticInfo guifg=#00ccff')
vim.cmd('highlight DiagnosticVirtualTextInfo guibg=#162a2f guifg=#00ccff')
vim.cmd('highlight DiagnosticHint guifg=#00ffff')
vim.cmd('highlight DiagnosticVirtualTextHint guibg=#162f2f guifg=#00ffff')
vim.cmd('highlight DiagnosticOk guifg=#00ff00')

-- Common plugins
vim.cmd('highlight TelescopeSelection guibg=#5d5d5d') -- Telescope selection

