if vim.b.fanfic then return end
vim.b.fanfic = true

local _location = debug.getinfo(1, "S").short_src
_location = _location:sub(1, #_location - #"/ftplugin/fanfic.lua")

vim.bo.commentstring = "/* %s */"
vim.bo.spelloptions = "camel"
vim.bo.spelllang = "en_us"
vim.bo.textwidth = 120
vim.o.cc = "120"

function SetTextWidth(size)
    if type(size) ~= "number" then
        size = vim.api.nvim_win_get_width(0)
        size = vim.fn.floor(size*0.80)
    end
    vim.bo.textwidth = size
    vim.o.cc = tostring(size)
end

local newline = ""
if not vim.fn.has("win32") then newline = "\n"
else newline = "\r\n" end

---@param dir string
---@return boolean
local function exists(dir)
    local thing = io.open(dir, "r")
    if thing ~= nil then
        io.close(thing)
        return true
    else
        return false
    end
end

local function getvisualselect()
    vim.cmd('noau normal! "vy"')
    return vim.fn.getreg('v')
end

local config_path = vim.fn.getcwd().."/fanfic.lua"
if exists(config_path) then
    local uv = require("luv")
    local config = require("fanfic")
    local bufnr = vim.api.nvim_get_current_buf()

    local remap_to_gmoves = config.remap_to_gmoves or true
    if remap_to_gmoves then
        vim.keymap.set("n", "k", "gk", { buffer = bufnr, noremap = true, silent = true })
        vim.keymap.set("n", "j", "gj", { buffer = bufnr, noremap = true, silent = true })
        vim.keymap.set("n", "$", "g$", { buffer = bufnr, noremap = true, silent = true })
        vim.keymap.set("n", "#", "g#", { buffer = bufnr, noremap = true, silent = true })
        vim.keymap.set("n", "0", "g0", { buffer = bufnr, noremap = true, silent = true })
        vim.keymap.set("n", "^", "g^", { buffer = bufnr, noremap = true, silent = true })
    end

    vim.keymap.set("n", "<leader>d", function()
        local word = vim.fn.expand("<cword>");
        vim.cmd(":!dict '"..word.."'")
    end, { buffer = bufnr, noremap = true, silent = false })
    vim.keymap.set("n", "<leader>D", function()
        local word = vim.fn.expand("<cWORD>");
        vim.cmd(":!dict '"..word.."'")
    end, { buffer = bufnr, noremap = true, silent = false })

    -- if not exists("./dico") then
    --     assert(os.execute("mkdir ./langs"))
    -- end
    --
    --
    -- local stdin = uv.new_pipe()
    -- local stdout = uv.new_pipe()
    -- local stderr = uv.new_pipe()
    -- local handle, pid = uv.spawn("dico", {
    --     stdio = { stdin, stdout, stderr },
    --     args = { "rlang" },
    -- }, function(code, signal)
    --         print("dico exit code", code)
    --         print("dico signal code", signal)
    --     end)
    --
    -- vim.api.nvim_create_autocmd({ "QuitPre" }, {
    --     desc = "Automagically close dico executable on vim quit",
    --     callback = function(arg)
    --         uv.kill(pid, "sigterm")
    --     end,
    -- })
    --
    -- vim.keymap.set("n", "<leader>d", function()
    --     local word = vim.fn.expand("<cword>")
    --     local command = "get-define "..word.." all\n"
    --     if not uv.is_writable(stdin) then
    --         error("WHY IS STDIN NOT WRITABLE???? LUVLIB SUCK IT")
    --         return
    --     end
    --     stdin:write(command)
    --     stdout:read_start(function(err, data)
    --         assert(not err, err)
    --         local function vnote()
    --             vim.fn.setreg("", data)
    --             vim.notify(data)
    --         end
    --         vim.schedule(vnote)
    --     end)
    --     stderr:read_start(function(err, data)
    --         assert(not err, err)
    --         local function vnote() vim.notify(data) end
    --         vim.schedule(vnote)
    --     end)
    -- end, { noremap=true, silent=false })
    --
    -- vim.api.nvim_create_user_command("Dico", function(cmd)
    --     local command = cmd.args.."\n"
    --     vim.notify(command)
    --     stdin:write(command)
    --     if not uv.is_writable then
    --         error("WHY IS STDIN NOT WRITABLE???? LUVLIB SUCK IT")
    --         return
    --     end
    --     stdout:read_start(function(err, data)
    --         assert(not err, err)
    --         local function vnote()
    --             vim.fn.setreg("", data)
    --             vim.notify(data)
    --         end
    --         vim.schedule(vnote)
    --     end)
    --     stderr:read_start(function(err, data)
    --         assert(not err, err)
    --         local function vnote() vim.notify(data) end
    --         vim.schedule(vnote)
    --     end)
    -- end, { nargs="+" })
end

vim.cmd(":setlocal spell")
