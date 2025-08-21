local last_dir = nil

local function get_dir_from_user(prompt)
    prompt = prompt or "Input to search: "
    local userin = vim.fn.input({
        prompt = prompt,
        default = last_dir,
        cancelreturn = vim.fn.getcwd(),
        completion = "dir",
    })
    if userin:len() == 0 then
        userin = last_dir or "~"
    end
    local result = vim.fn.expand(userin)
    last_dir = result
    return result
end

return {
    {   -- todo, disable netrw
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "echasnovski/mini.icons" },
        lazy = false, -- Lazy loading is not recommended because it is tricky to make it work correctly in all situations.
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    -- "mtime",
                },
                buf_options = {
                    buflisted = false,
                    bufhidden = "hide",
                },
                win_options = {
                    wrap = true,
                    signcolumn = "no",
                    cursorcolumn = false,
                    foldcolumn = "0",
                    spell = false,
                    list = false,
                    conceallevel = 3,
                    concealcursor = "nvic",
                },
                delete_to_trash = false,
                skip_confirm_for_simple_edits = true,
                prompt_save_on_select_new_entry = true,
                cleanup_delay_ms = 2000,
                lsp_file_methods = {
                    enabled = false,
                    timeout_ms = 1000,
                    autosave_changes = false,
                },
                -- Constrain the cursor to the editable parts of the oil buffer
                -- Set to `false` to disable, or "name" to keep it on the file names
                constrain_cursor = "editable",
                watch_for_changes = true, -- maybe change this
                -- Set to `false` to remove a keymap
                -- See :help oil-actions for a list of all available actions
                keymaps = {
                    ["g?"]    = { mode = "n", "actions.show_help" },
                    ["<CR>"]  =               "actions.select",
                    ["<C-p>"] =               "actions.preview",
                    ["<C-c>"] = { mode = "n", "actions.close" },
                    ["<C-l>"] =               "actions.refresh",
                    ["-"]     = { mode = "n", "actions.parent"},
                    ["_"]     = { mode = "n", "actions.open_cwd" },
                    ["gs"]    = { mode = "n", "actions.change_sort" },
                    ["gx"]    =               "actions.open_external",
                    ["g."]    = { mode = "n", "actions.toggle_hidden" },
                    ["g\\"]   = { mode = "n", "actions.toggle_trash" },
                },
                use_default_keymaps = true, -- true enables the above code???
                view_options = {
                    show_hidden = true,
                    is_hidden_file = function(name, bufnr)
                        local m = name:match("^%.")
                        return m ~= nil
                    end,
                    is_always_hidden = function(name, bufnr)
                        return false
                    end,
                    -- Sort file names with numbers in a more intuitive order for humans.
                    -- Can be "fast", true, or false. "fast" will turn it off for large directories.
                    natural_order = "fast",
                    -- Sort file and directory names case insensitive
                    case_insensitive = false,
                    sort = {
                        -- sort order can be "asc" or "desc"
                        -- see :help oil-columns to see which columns are sortable
                        { "type", "asc" },
                        { "name", "asc" },
                    },
                    highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
                        return nil
                    end,
                },
                -- Extra arguments to pass to SCP when moving/copying files over SSH
                extra_scp_args = {},
                -- EXPERIMENTAL support for performing file operations with git
                git = {
                    add = function(path)                return false end, -- Return true to automatically git add/mv/rm files
                    mv =  function(src_path, dest_path) return false end, -- Return true to automatically git add/mv/rm files
                    rm =  function(path)                return false end, -- Return true to automatically git add/mv/rm files
                },
                float = {
                    padding = 2,
                    max_width = 0,
                    max_height = 0,
                    border = "rounded",
                    win_options = {
                        winblend = 0,
                    },
                    get_win_title = nil,
                    preview_split = "auto",
                    override = function(conf)
                        return conf
                    end,
                },
                preview_win = {
                    update_on_cursor_moved = true,
                    preview_method = "fast_scratch", -- How to open the preview window "load"|"scratch"|"fast_scratch"
                    -- A function that returns true to disable preview on a file e.g. to avoid lag
                    disable_preview = function(filename)
                        return false
                    end,
                    win_options = {},
                },
                confirmation = {
                    max_width = 0.9,
                    min_width = { 40, 0.4 },
                    width = nil,
                    max_height = 0.9,
                    min_height = { 5, 0.1 },
                    height = nil,
                    border = "rounded",
                    win_options = {
                        winblend = 0,
                    },
                },
                progress = {
                    max_width = 0.9,
                    min_width = { 40, 0.4 },
                    width = nil,
                    max_height = { 10, 0.9 },
                    min_height = { 5, 0.1 },
                    height = nil,
                    border = "rounded",
                    minimized_border = "none",
                    win_options = {
                        winblend = 0,
                    },
                },
                ssh = { border = "rounded" },
                keymaps_help = { border = "rounded" },
            })

            local oil = require("oil")

            vim.keymap.set("n", "<leader>pv", function() oil.open(vim.fn.getcwd()) end,
                {silent=true,noremap=true,desc="Opens Filesystem in CWD" })
            vim.keymap.set("n", "<leader>lv", function() oil.open() end,
                {silent=true,noremap=true,desc="Opens Filesystem in current buffers directory" })
            vim.keymap.set("n", "<leader>uv", function() oil.open(get_dir_from_user("Directory to Open: ")) end,
                {silent=true,noremap=true,desc="Opens Filesystem in user specified directory" })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({})

            -- Enable line numbers in telescope
            vim.api.nvim_create_autocmd("User", {
                pattern = "TelescopePreviewerLoaded",
                callback = function()
                    vim.wo.wrap = true
                    vim.wo.nu = true
                end,
            })

            local builtin = require("telescope.builtin")

            local function get_local_dir()
                return vim.fn.expand("%:p:h")
            end

            vim.keymap.set("n", "<leader>m", builtin.man_pages,
                {silent=true,noremap=true,desc="Search man pages"})

            vim.keymap.set("n", "<leader>pf", builtin.find_files,
                {silent=true,noremap=true,desc="Find file in CWD"})
            vim.keymap.set("n", "<leader>ps", builtin.live_grep,
                {silent=true,noremap=true,desc="Find string in CWD"})
            vim.keymap.set("n", "<leader>pw", builtin.grep_string,
                {silent=true,noremap=true,desc="Find word under cursor in CWD"})
            vim.keymap.set("n", "<leader>pW", function() vim.cmd(":norm! viW") builtin.grep_string() end,
                {silent=true,noremap=true,desc="Find word up unitl whitespace under cursor in CWD"})
            vim.keymap.set("x", "<leader>p", builtin.grep_string,
                {silent=true,noremap=true,desc="Find visual selection in CWD"})

            vim.keymap.set("n", "<leader>lf", function() builtin.find_files({cwd=get_local_dir()}) end,
                {silent=true,noremap=true,desc="Find file in the current buffers location"})
            vim.keymap.set("n", "<leader>ls", function() builtin.live_grep({cwd=get_local_dir()}) end,
                {silent=true,noremap=true,desc="Find string in the current buffers location"})
            vim.keymap.set("n", "<leader>lw", function() builtin.grep_string({cwd=get_local_dir()}) end,
                {silent=true,noremap=true,desc="Find word under cursor in the current buffers location"})
            vim.keymap.set("n", "<leader>lW", function() vim.cmd(":norm! viW") builtin.grep_string({cwd=get_local_dir()}) end,
                {silent=true,noremap=true,desc="Find word up unitl whitespace under cursor in the current buffers location"})
            vim.keymap.set("x", "<leader>l", function() builtin.grep_string({cwd=get_local_dir()}) end,
                {silent=true,noremap=true,desc="Find visual selection in the current buffers location"})

            vim.keymap.set("n", "<leader>uf", function() builtin.find_files({cwd=get_dir_from_user("Input to search files: ")}) end,
                {silent=true,noremap=true,desc="Find file in the current buffers location"})
            vim.keymap.set("n", "<leader>us", function() builtin.live_grep({cwd=get_dir_from_user("Input to search string: ")}) end,
                {silent=true,noremap=true,desc="Find string in the current buffers location"})
            vim.keymap.set("n", "<leader>uw", function() builtin.grep_string({cwd=get_dir_from_user("Input to search word: ")}) end,
                {silent=true,noremap=true,desc="Find word under cursor in the current buffers location"})
            vim.keymap.set("n", "<leader>uW", function() vim.cmd(":norm! viW") builtin.grep_string({cwd=get_local_dir("Input to search word: ")}) end,
                {silent=true,noremap=true,desc="Find word up unitl whitespace under cursor in the current buffers location"})
            vim.keymap.set("x", "<leader>u", function() builtin.grep_string({cwd=get_dir_from_user("Input to search visual selection: ")}) end,
                {silent=true,noremap=true,desc="Find visual selection in the current buffers location"})

            vim.keymap.set("n", "<F1>", builtin.help_tags, { silent=true,noremap=true,desc="Better F1" })
            vim.keymap.set("n", "<leader>hw", function()
                local word = vim.fn.expand("<cword>")
                builtin.help_tags()
                vim.cmd.norm("i"..word)
            end, {silent=true,noremap=true,desc="Find word under cursor in help tags"})
            vim.keymap.set("n", "<leader>hW", function()
                local word = vim.fn.expand("<cWORD>")
                builtin.help_tags()
                vim.cmd.norm("i"..word)
            end, {silent=true,noremap=true,desc="Find word up unitl whitespace under cursor in help tags"})
        end,
    }
}
