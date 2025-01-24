vim.api.nvim_set_hl(0, "StatusFile", { fg="Cyan", bg="#004b4b" })

vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg="Red", bg="none", bold=true, ctermbg=0 })
vim.fn.sign_define("DiagnosticSignError", { text="", texthl="DiagnosticSignError", linehl="", numhl="DiagnosticSignError" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg="Yellow", bg="none", bold=true, ctermbg=0 })
vim.fn.sign_define("DiagnosticSignWarn", { text="", texthl="DiagnosticSignWarn", linehl="", numhl="DiagnosticSignWarn" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg="Cyan", bg="none", bold=true, ctermbg=0 })
vim.fn.sign_define("DiagnosticSignHint", { text="", texthl="DiagnosticSignHint", linehl="", numhl="DiagnosticSignHint" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg="#5a7dff", bg="none", bold=true, ctermbg=0 })
vim.fn.sign_define("DiagnosticSignInfo", { text="ℹ", texthl="DiagnosticSignInfo", linehl="", numhl="DiagnosticSignInfo" })

FileTypeSymbols = {
    ["oil"] = "",
    ["toggleterm"] = "",
    ["gitcommit"] = "󰊢",
}

function StatusLine_FileSymbol()
    local sym = FileTypeSymbols[vim.bo.filetype]-- or 
    if sym ~= nil then return sym
    else return "" end
end

function StatusLine_FileName()
    local fullpath = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd().."/"
    local _, cwd_end = string.find(fullpath, cwd, 1, true)

    local _, term = string.find(fullpath, "term:/", 1, true)
    if term ~= nil then return "terminal: "..vim.o.shell end

    local _, oil = string.find(fullpath, "oil://", 1, true)
    if oil ~= nil then return string.sub(fullpath, oil + 1, #fullpath) end

    local result = ""
    if cwd_end ~= nil then result = string.sub(fullpath, cwd_end + 1, #fullpath)
    else result = fullpath end
    return result.."["..vim.o.filetype.."]"
end

function StatusLine_FileSize()
    local size = vim.fn.getfsize(vim.fn.expand("%:p"))
    if size == -1 then return "󱛟 0B" end

    local prefix = "B"
    if size > 1024 then
        size = size / 1024
        prefix = "kiB"
    end
    if size > 1024 then
        size = size / 1024
        prefix = "MiB"
    end
    if size > 1024 then
        size = size / 1024
        prefix = "GiB"
    end
    if size > 1024 then
        size = size / 1024
        prefix = "TiB"
    end
    if size > 1024 then
        size = size / 1024
        prefix = "PiB"
    end

    local result = tostring(size)..prefix
    if prefix ~= "B" then result = string.format("%.3f", size)..prefix end
    return "󱛟 "..result
end

function StatusLine_Diagnostic()
    local diagnostics = vim.diagnostic.get(0)
    if #diagnostics == 0 then return "" end

    --                   e  w  h  i
    local severities = { 0, 0, 0, 0 }
    for _, dia in ipairs(diagnostics) do
        severities[dia.severity] = severities[dia.severity] + 1
    end

    local statW = "%#StatusDiaWarn#"..(vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text or "W")..tostring(severities[2]).." "
    local statE = "%#StatusDiaError#"..(vim.fn.sign_getdefined("DiagnosticSignError")[1].text or "E")..tostring(severities[1]).." "
    local statH = "%#StatusDiaHint#"..(vim.fn.sign_getdefined("DiagnosticSignHint")[1].text or "H")..tostring(severities[3]).." "
    local statI = "%#StatusDiaInfo#"..(vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text or "I")..tostring(severities[4]).." "

    local result = ""
    if severities[1] > 0 then result = result..statE end
    if severities[2] > 0 then result = result..statW end
    if severities[3] > 0 then result = result..statH end
    if severities[4] > 0 then result = result..statI end

    return result.."%#StatusFile#"
end

function StatusLine_Spell()
    if vim.o.spell then return vim.o.spelllang
    else return "" end
end

function StatusLine_Lsp()
    local current = vim.api.nvim_get_current_buf()
    local servers = vim.lsp.get_clients({ bufnr=current })

    if #servers == 0 then return "" end
    if #servers == 1 then return " "..servers[1].name end

    local result = " {"
    for i = 1, #servers, 1 do
        local tail = ","
        if i == #servers then tail = "" end
        result = result..servers[i].name..tail
    end
    return result.."}"
end

vim.api.nvim_set_hl(0, "StatusDiaError", { fg="Red",     bg="#004b4b" })
vim.api.nvim_set_hl(0, "StatusDiaWarn",  { fg="Yellow",  bg="#004b4b" })
vim.api.nvim_set_hl(0, "StatusDiaHint",  { fg="Cyan",    bg="#004b4b" })
vim.api.nvim_set_hl(0, "StatusDiaInfo",  { fg="#5a7dff", bg="#004b4b" })

local cursor_line = vim.api.nvim_get_hl(0, { name="CursorLine" })
vim.api.nvim_set_hl(0, "CursorColumn", { fg=nil, bg=cursor_line.bg })

vim.opt.statusline = "%#StatusFile# %{luaeval('StatusLine_FileSymbol()')} %{luaeval('StatusLine_FileName()')}%m%h%r      b%n %c:%p%%%=%{%luaeval('StatusLine_Diagnostic()')%}    %{luaeval('StatusLine_Spell()')}    %{luaeval('StatusLine_Lsp()')}    %{luaeval('StatusLine_FileSize()')} "
