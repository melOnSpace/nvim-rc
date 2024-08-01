local M = {}

M.HOMEDIR = vim.fn.expand("$HOME")
M.WILDCARD = "@"

M.directory_wildcards = {
    ["~"] = M.HOMEDIR,
    ["p"] = M.HOMEDIR.."/prog",
    ["g"] = M.HOMEDIR.."/git",
    ["c"] = M.HOMEDIR.."/.config/nvim",
    ["d"] = M.HOMEDIR.."/.local/share/nvim",
}

---@param prompt string
---@return string|nil
function M.query_directory(prompt)
    local input = vim.fn.input({ prompt = prompt })
    if input == nil or #input <= 0 then return nil end

    if input == "@h" or string.lower(input) == "help" then
        local help = "Wildcards for "..prompt.."\n\n"
        for key, value in pairs(M.directory_wildcards) do
            help = help.."@"..tostring(key).." -> "..value.."\n"
        end

        return help
    end

    local full_directory = ""

    local prev = ""
    for i = 1, #input, 1 do
        local curr = input:sub(i, i)

        if prev == "@" then
            local dir = M.directory_wildcards[curr]
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
