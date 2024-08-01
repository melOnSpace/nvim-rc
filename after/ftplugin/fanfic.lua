vim.b.fanfic = true
---@diagnostic disable: undefined-global

---@alias pipe userdata
---@alias microseconds integer
---@alias Msg_Cmd integer

local dico = require("dico-client")

---@class Server
---@field loaded_dicos table
---@field handle userdata
---@field pid userdata
---@field stdout pipe
---@field stdin pipe
---@field stderr pipe
---@field socket pipe
---@field socket_path string|nil
---@field cmd_exit function<self>
---@field cmd_pass function<self, microseconds>
---@field cmd_version function<self>
---@field compose_cmd function<self, Msg_Cmd>: string
---@field is_zero function<self>: boolean
---@field launch function<self>
local local_server
local current_cwd = dico.get_cwd()
if Dico_Servers[current_cwd] == nil then
    Dico_Servers[current_cwd] = dico.server_new()
end

local_server = Dico_Servers[current_cwd]
local_server:launch(function()
    local_server:cmd_version(function(version)
        vim.schedule(function()
            vim.print(version)
        end)
    end)
end)
