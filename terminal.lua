local uv = require("luv")

local default_setup = {
    compilation_alias = {
        ["grep"] = "grep --color=auto",
        ["nob"] = "./nob", -- nob build system (because ./ is too much to write i guess)
        ["sob"] = "./sob", -- sob build system (because ./ is too much to write i guess)
        ["ls"] = "ls -aFh --color=always --group-directories-first",
        ["ll"] = "ls -aFhl --color=always --group-directories-first", -- like ls but list
        ["lf"] = "ls -aFhl --color=always --group-directories-first | egrep -v '^d'", -- like ll but only files
        ["ldir"] = "ls -aFhl --color=always --group-directories-first | egrep '^d'", -- like ll but only dirs
    },
}

local state = {
    comp_bufnr = -1,
    comp_winid = -1,
    comp_chan = -1,
    comp_input_buffer = "",

    term_bufnr = -1,

    og_bufnr = -1,
    og_winid = -1,

    compilation_alias = default_setup.compilation_alias,
}

vim.cmd(":au! nvim.terminal TermClose")

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("my_term_group", { clear=true }),
    callback = function(args)
        vim.wo[0][0].rnu = true
        vim.wo[0][0].nu = true
    end,
})

vim.api.nvim_create_autocmd("TermClose", {
    group = vim.api.nvim_create_augroup("compmode_term_group", { clear=true }),
    callback = function()
        if vim.api.nvim_buf_is_valid(state.og_bufnr) then
            vim.api.nvim_set_current_buf(state.og_bufnr)
        end
    end,
})

local function setup(opts)
    opts = opts or default_setup

    for key, value in ipairs(opts) do
        if key == compilation_alias then
            state.compilation_alias = value
        else
            error("Unknown setup key '"..tostring(value).."'", 2)
            return
        end
    end
end

function destroy_tty(tty)
    if tty.stdin  ~= nil then tty.stdin:close();  tty.stdin  = nil end
    if tty.stdout ~= nil then tty.stdout:close(); tty.stdout = nil end
    if tty.stderr ~= nil then tty.stderr:close(); tty.stderr = nil end
end

local function create_tty()
    local result = {
        destroy = destroy_tty,
        stdin = nil,  
        stdout = nil, 
        stderr = nil, 
    }
    result.stdin = uv.new_tty(0, false)
    result.stdout = uv.new_tty(1, true)
    result.stderr = uv.new_tty(2, true)

    ::cleanup::
    local success = true
    success = success and (result.stdin ~= nil)
    success = success and (result.stdin ~= nil)
    success = success and (result.stdin ~= nil)

    if not success then
        result:destory()
        return nil
    else
        return result
    end
end

local function term_input_callback(input, term, bufnr, data)
end

local function toggle_comp_window()
    if not vim.api.nvim_buf_is_valid(state.comp_bufnr) then
        state.comp_bufnr = vim.api.nvim_create_buf(false, false)
        assert(vim.api.nvim_buf_is_valid(state.comp_bufnr))
        vim.api.nvim_set_option_value("modifiable", false, { buf=state.comp_bufnr,scope="local" })
        vim.api.nvim_set_option_value("undolevels", -1, { buf=state.comp_bufnr,scope="local" })
        vim.api.nvim_set_option_value("scrollback", vim.o.scrollback < 0 and 10000 or math.max(1, vim.o.scrollback), { buf=state.comp_bufnr,scope="local" })
        vim.api.nvim_set_option_value("textwidth", 0, { buf=state.comp_bufnr,scope="local" })
        state.comp_chan = vim.api.nvim_open_term(state.comp_bufnr, {on_input=term_input_callback})
        state.comp_input_buffer = ""
    end

    if not vim.api.nvim_win_is_valid(state.comp_winid) then
        state.og_bufnr = vim.api.nvim_get_current_buf()
        state.og_winid = vim.api.nvim_get_current_win()
        state.comp_winid = vim.api.nvim_open_win(state.comp_bufnr, true, {win=0,split="below"})
        assert(vim.api.nvim_win_is_valid(state.comp_winid))
        vim.api.nvim_set_option_value("wrap", false, { win=state.comp_winid,scope="local" })
        vim.api.nvim_set_option_value("list", false, { win=state.comp_winid,scope="local" })
        vim.api.nvim_set_option_value("signcolumn", "no", { win=state.comp_winid,scope="local" })
        vim.api.nvim_set_option_value("wrap", false, { win=state.comp_winid,scope="local" })
        vim.api.nvim_set_option_value("foldcolumn", "0", { win=state.comp_winid,scope="local" })
    else
        vim.api.nvim_win_hide(state.comp_winid)
    end
end

local function toggle_term_buffer()
    if not vim.api.nvim_buf_is_valid(state.term_bufnr) then
        state.term_bufnr = vim.api.nvim_create_buf(false, false)
        assert(vim.api.nvim_buf_is_valid(state.term_bufnr))
    end

    local cur_buf = vim.api.nvim_get_current_buf()
    if cur_buf ~= state.term_bufnr then
        state.og_bufnr = cur_buf
        vim.api.nvim_set_current_buf(state.term_bufnr)
        if not vim.b.term_title then
            vim.cmd.terminal()
        end
        vim.cmd.startinsert()
    else
        vim.api.nvim_set_current_buf(state.og_bufnr)
    end
end

local function get_command_to_run()
    local command_to_run = vim.fn.input({
        prompt = "Cmd: ",
        completion = "shellcmdline",
        highlight = function(userin)
            userin = userin:match("^%s*(.*)") -- magical Lua incantation to remove trailing whitespace
            if userin:len() == 0 then return { {0,1,"None"} } end
            local first_ws = userin:find("%s+") or 1e6
            assert(type(first_ws) == "number")
            if first_ws >= userin:len() then
                return { {0, userin:len(), "Statement"} }
            else
                return { {0, first_ws, "Statement"}, { first_ws, userin:len(), "Special" } }
            end
        end,
    })
    if command_to_run:len() == 0 then
        return ""
    end

    return command_to_run
end

-- vim.keymap.set("n", "<leader><leader>x", function()
--     P(get_command_to_run())
-- end)

-- vim.keymap.set({ "n", "t" }, "g\\", toggle_comp_window)
vim.keymap.set({ "n", "t" }, "<C-\\>", toggle_term_buffer)

return {
    toggle_term_buffer,
    toggle_comp_window,
    get_command_to_run,

    setup = setup,
    default_setup = default_setup,
}
