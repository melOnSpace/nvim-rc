local function file_part()
    local highlight_group = ""-- "%#Status#"
    local filetype = "["..vim.bo.filetype.."] "
    local path = vim.fn.expand("%:p")
    local modifiers = "%m%r%h%w"

    local cwd = vim.fn.getcwd().."/"
    local home = vim.fn.expand("~").."/"
    local term = "term://"
    local oil = "oil://"

    if vim.fn.has("win32") ~= 1 then
        if path:sub(1, term:len()) == term then
            local pid_and_shell = string.find(path, "%d+:/[^%s]")
            path = path:sub(pid_and_shell, path:len())
            filetype = "[term] "
        elseif path:sub(1, oil:len()) == oil then
            path = path:sub(oil:len() + 1, path:len())
        end
    end

    if path:sub(1, cwd:len()) == cwd then
        path = "./"..path:sub(cwd:len() + 1, path:len())
    elseif path:sub(1, home:len()) == home then
        path = "~/"..path:sub(home:len() + 1, path:len())
    end

    return filetype..highlight_group..path..modifiers
end

local function position_part()
    return "%p%%    %l:%c"
end

local function vim_part()
    local modes = {
        ["n"]   = { color="Status", text="normal" },
        ["no"]  = { color="Status", text="normal op-pending" },
        ["nov"] = { color="Status", text="normal op-pending" },
        ["noV"] = { color="Status", text="normal op-pending" },
        ["no"]= { color="Status", text="normal op-pending" },
        ["niI"] = { color="Status", text="normal using |insert|" },
        ["niR"] = { color="Status", text="normal using |replace|" },
        ["niV"] = { color="Status", text="normal using |virtual-replace|" },
        ["nt"]  = { color="Status", text="normal in terminal" },
        ["ntT"] = { color="Status", text="normal using |terminal|" },
        ["v"]   = { color="Directory", text="visual" },
        ["vs"]  = { color="Directory", text="visual using |select|" },
        ["V"]   = { color="Directory", text="visual-line" },
        ["Vs"]  = { color="Directory", text="visual-line using |select|" },
        [""]  = { color="Directory", text="visual-block" },
        ["s"] = { color="Directory", text="visual-block using |select|" },
        ["s"]   = { color="Statement", text="select" },
        ["S"]   = { color="Statement", text="select-line" },
        [""]  = { color="Statement", text="select-block" },
        ["i"]   = { color="CursorLineNr", text="insert" },
        ["ic"]  = { color="CursorLineNr", text="insert-completion [generic]" },
        ["ix"]  = { color="CursorLineNr", text="insert-completion [ctrl-X]" },
        ["R"]   = { color="Keyword", text="replace" },
        ["Rc"]  = { color="Keyword", text="replace-completion [generic]" },
        ["Rx"]  = { color="Keyword", text="replace-completion [ctrl-X]" },
        ["Rv"]  = { color="Keyword", text="virtual-replace" },
        ["Rvc"] = { color="Keyword", text="virtual-replace-completion [generic]" },
        ["Rvx"] = { color="Keyword", text="virtual-replace-completion [ctrl-X]" },
        ["c"]   = { color="ModeMsg", text="command" },
        ["cr"]  = { color="ModeMsg", text="command-overstrike" },
        ["cv"]  = { color="ModeMsg", text="vim-Ex [gQ]" },
        ["cvr"] = { color="ModeMsg", text="vim-Ex-overstrike [gQ]" },
        ["r"]   = { color="Comment", text="hit-enter" },
        ["rm"]  = { color="Comment", text="-- more --" },
        ["r?"]  = { color="Comment", text="|:confirm| query" },
        ["!"]   = { color="Comment", text="shell is executing" },
        ["t"]   = { color="CursorLineNr", text="terminal" },
    }
    local found = modes[vim.fn.mode()] or { color="DiagnosticError", text="unknown-mode '"..tostring(vim.fn.mode():byte()).."'" }

    local lang = vim.bo.spelllang
    local result = "%#"..found.color.."#*"..found.text.."*"
    if vim.o.spell then
        result = lang.."    "..result
    end
    return result
end

function Final_Status_Line()
    return file_part().."   "..position_part().."%="..vim_part()
end

vim.opt.statusline = "%{%luaeval('Final_Status_Line()')%}"
