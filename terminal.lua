local state = {
    bufnr = -1,
    bufnr_before = -1,
    cmd = "",
    cmd_before = "",
}

vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("compmode_term_group", { clear=true }),
    callback = function()
        vim.cmd(":setlocal rnu")
        vim.cmd(":setlocal nu")
    end,
})

local function run_cmd()
    if not vim.api.nvim_buf_is_valid(state.bufnr) then
        state.bufnr = vim.api.nvim_create_buf(false, false)
        assert(vim.api.nvim_buf_is_valid(state.bufnr))
    end

    vim.api.nvim_set_current_buf(state.bufnr)
    local shell = vim.fn.environ()["SHELL"] or "/bin/sh"
    vim.cmd(":terminal "..shell.." -c ")
end

local function input_cmd_and_run()
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
                return { {0, first_ws, "Statement"}, { first_ws, userin:len(), "Directory" } }
            end
        end,
    })
    if command_to_run:len() == 0 then
        return
    end

    state.cmd_before = state.cmd
    state.cmd = command_to_run
    run_cmd()
end

vim.keymap.set("n", "<C-\\>", input_cmd_and_run, {silent=true,noremap=true,desc="My attempt of comp-mode (i should just use emacs)"})

-- local state = {
--     prev = -1,
--     bufnr = -1,
-- }
--
-- vim.api.nvim_create_user_command("Gf", function()
--     local vimline = vim.fn.getline(".")
--     vimline = vimline:match("^%s*(.-)%s*$")
--
--     if not vimline:match("^[^%s]+:%d[:%d+]?") then
--         vim.print("Failed to find 'file:line:col' in line")
--         return
--     end
--
--     local file = vimline:match("^[^%s]+:")
--     local line = ""
--     local column = ""
--     P(file)
-- end, {})
--
-- local function toggle_compmode()
--     if not vim.api.nvim_buf_is_valid(state.bufnr) then
--         state.bufnr = vim.api.nvim_create_buf(false, false)
--         assert(vim.api.nvim_buf_is_valid(state.bufnr))
--         vim.keymap.set("n", "gf", ":Gf<cr>", {buffer=state.bufnr,silent=true,noremap=true,desc="Goto File:Line:Column in the line"})
--         vim.keymap.set("n", "gF", ":Gf<cr>", {buffer=state.bufnr,silent=true,noremap=true,desc="Goto File:Line:Column in the line (alias of 'gf')"})
--         vim.api.nvim_buf_call(state.bufnr, function()
--             vim.cmd.term()
--             vim.cmd.norm("i")
--         end)
--     end
--
--     if vim.api.nvim_get_current_buf() ~= state.bufnr then
--         state.prev = vim.api.nvim_get_current_buf()
--         vim.api.nvim_set_current_buf(state.bufnr)
--     else
--         assert(vim.api.nvim_buf_is_valid(state.prev))
--         vim.api.nvim_set_current_buf(state.prev)
--     end
-- end
--
-- vim.keymap.set({ "n", "t" }, "<C-\\>", toggle_compmode, {silent=true,noremap=true,desc="Opens a 'compmode' like terminal"})
--
