local M = {}

M.HOMEDIR = vim.fn.expand("$HOME")
M.WILDCARD = "@"

M.wildcard_dirs = {
    ["c"] = vim.fn.stdpath("config"),
    ["d"] = vim.fn.stdpath("data"),
    ["s"] = vim.fn.stdpath("state"),
}
if vim.fn.has("linux") ~= 0 then
    M.wildcard_dirs["~"] = M.HOMEDIR
    M.wildcard_dirs["p"] = M.HOMEDIR.."/prog"
    M.wildcard_dirs["g"] = M.HOMEDIR.."/git"
    M.wildcard_dirs["o"] = M.HOMEDIR.."/git/Odin/"
elseif vim.fn.has("win32") ~= 0 then
    M.wildcard_dirs["~"] = M.HOMEDIR
    M.wildcard_dirs["p"] = M.HOMEDIR.."C:\\prog"
    M.wildcard_dirs["g"] = M.HOMEDIR.."C:\\git"
    -- M.wildcard_dirs["o"] = M.HOMEDIR
end

---@param prompt string
---@return string|nil
function M.query_directory(prompt)
    local input = vim.fn.input({ prompt = prompt })
    if input == nil or #input <= 0 then return nil end

    if input == "@h" or string.lower(input) == "help" then
        local help = "Wildcards for "..prompt.."\n\n"
        for key, value in pairs(M.wildcard_dirs) do
            help = help.."@"..tostring(key).." -> "..value.."\n"
        end

        return help
    end

    local full_directory = ""

    local prev = ""
    for i = 1, #input, 1 do
        local curr = input:sub(i, i)

        if prev == "@" then
            local dir = M.wildcard_dirs[curr]
            if dir == nil then goto continue end
            full_directory = full_directory:sub(1, #full_directory - 1)
            full_directory = full_directory..dir
        else
            full_directory = full_directory..curr
        end

        ::continue::
        prev = curr
    end

    return full_directory
end

---@param dir string
---@return boolean
function M.exists(dir)
    local thing = io.open(dir, "r")
    if thing ~= nil then
        io.close(thing)
        return true
    else
        return false
    end
end

return M
