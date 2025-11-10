local uv = require("luv")

local state = {
    term_bufnr = -1,
    og_bufnr = -1,
    og_winid = -1,
}

vim.cmd(":au! nvim.terminal TermClose")

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(args)
        vim.wo[0][0].rnu = true
        vim.wo[0][0].nu = true
    end,
})

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
        if vim.api.nvim_buf_is_valid(state.og_bufnr) then
            vim.api.nvim_set_current_buf(state.og_bufnr)
        else
            vim.print("could not find original buffer")
        end
    end
end

vim.keymap.set({ "n", "t" }, "<C-\\>", toggle_term_buffer)
vim.keymap.set("t", "<C-r>", function()
    assert(vim.api.nvim_buf_is_valid(0))
    vim.api.nvim_buf_delete(0, {force=true})
    toggle_term_buffer()
end)

return {
    toggle_term_buffer,
}
