" mel-desert
" created on https://nvimcolors.com

highlight clear
syntax reset

" Basic UI elements
highlight Normal guibg=#181818 guifg=#ffffff
highlight NormalFloat guibg=none guifg=#ffffff
highlight NonText guibg=none guifg=#8888a8
highlight CursorLine guibg=#2f2f2f
highlight LineNr guifg=#585858
highlight CursorLineNr guifg=#eeee00
highlight SignColumn guibg=#181818
highlight StatusLine guibg=#2f2f2f guifg=#ffffff
highlight StatusLineNC guibg=#2f2f2f guifg=#242424
highlight Directory guifg=#33ffff
highlight Visual guibg=#4d4d4d
highlight Search guibg=#8c8c8c guifg=#f9f06b
highlight CurSearch guibg=#e5a50a guifg=#181818
highlight IncSearch gui=None guibg=#e5a50a guifg=#181818
highlight MatchParen guibg=#8c8c8c guifg=#f9f06b
highlight Pmenu guibg=#464646 guifg=#ffffff
highlight PmenuSel guibg=#e5a50a guifg=#181818
highlight PmenuSbar guibg=#7e7e7e guifg=#ffffff
highlight VertSplit guifg=#545454
highlight MoreMsg guifg=#ffa0a0
highlight Question guifg=#ffa0a0
highlight Title guibg=none guifg=#ffffff gui=underline

" Spell Highlighting
highlight SpellBad guifg=red guibg=none gui=underline,bold
highlight SpellCap guifg=yellow guibg=none gui=underline,bold
highlight SpellRare guifg=cyan guibg=none gui=underline
highlight SpellLocal guifg=red guibg=none gui=bold

" Syntax highlighting
highlight Comment guifg=#8c8c8c
" highlight Comment guifg=#6dceeb
highlight Constant guifg=#ffa0a0
highlight Identifier guifg=#ffffff
highlight Statement guifg=#f0e68c guibg=NONE gui=bold cterm=bold
highlight PreProc guifg=#bdb76b guibg=NONE
highlight Type guifg=#bdb76b guibg=NONE gui=bold cterm=bold
highlight Special guifg=#a0eeee

" Refined syntax highlighting
highlight String guifg=#ffa0a0
" highlight String guifg=#60cc60
highlight Number guifg=#ffffff
highlight Boolean guifg=#ffa0a0
highlight Function guifg=#ffffff
" highlight Keyword guifg=#c2bfa5
highlight Keyword guifg=#f0e68c

" Html syntax highlighting
highlight Tag guifg=#eeee00
highlight @tag.delimiter guifg=#ffa0a0
highlight @tag.attribute guifg=#ffffff

" Messages
highlight ErrorMsg guifg=#ff0000
highlight Error guifg=#ff0000
highlight DiagnosticError guifg=#ff0000
highlight DiagnosticVirtualTextError guibg=#2f1616 guifg=#ff0000
highlight WarningMsg guifg=#ffcc00
highlight DiagnosticWarn guifg=#ffcc00
highlight DiagnosticVirtualTextWarn guibg=#2f2a16 guifg=#ffcc00
highlight DiagnosticInfo guifg=#00ccff
highlight DiagnosticVirtualTextInfo guibg=#162a2f guifg=#00ccff
highlight DiagnosticHint guifg=#00ffff
highlight DiagnosticVirtualTextHint guibg=#162f2f guifg=#00ffff
highlight DiagnosticOk guifg=#00ff00

" Common plugins
highlight TelescopeSelection guibg=#5d5d5d

