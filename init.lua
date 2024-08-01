function P(input) vim.print(input) end

---@diagnostic disable-next-line: param-type-mismatch
package.path = package.path .. ";"..vim.fn.stdpath("config").."/?.lua"
require("packages")
require("set")
require("status")
require("remap")

local utils = require("utils")

-- -@param string description
---@return table
local function nore(description)
    return { noremap = true, silent = true, desc = description }
end

-----------------
-- Dico Config --
-----------------
require("dico-client").setup()

------------------
-- Align Config --
------------------
vim.keymap.set("x", "gp", function()
    require("align").align_to_string({ regex = true, preview = true })
end, { noremap = true, silent = true, desc = "Align selection by pattern" })
vim.keymap.set("x", "ga", function()
    require("align").align_to_string({ regex = false, preview = true })
end, { noremap = true, silent = true, desc = "Align selection by string" })

----------------------
-- Telescope Config --
----------------------
require("telescope").setup({})
vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopePreviewerLoaded",
    callback = function()
        vim.wo.wrap = true
        vim.wo.nu = true
    end,
})

local ts_builtin = require("telescope.builtin")

vim.keymap.set("n", "<F1>", ts_builtin.help_tags, nore("Open telescope help tags"))

local function find_project() ts_builtin.find_files() end
local function srep_project() ts_builtin.live_grep() end
local function word_project() ts_builtin.grep_string() end
local function Word_project() vim.cmd(":norm! viW") ts_builtin.grep_string() end

vim.keymap.set("n", "<leader>pf", find_project, nore("Search Current Working Directory for file"))
vim.keymap.set("n", "<leader>ps", srep_project, nore("Search Current Working Directory for string"))
vim.keymap.set("n", "<leader>pw", word_project, nore("Search Current Working Directory for word under cursor"))
vim.keymap.set("n", "<leader>pW", Word_project, nore("Search Current Working Directory for WORD under cursor"))


local function find_local()
    ts_builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
end

local function srep_local()
    ts_builtin.live_grep({ cwd = vim.fn.expand("%:p:h") })
end

local function word_local()
    ts_builtin.grep_string({ cwd = vim.fn.expand("%:p:h") })
end

local function Word_local()
    vim.cmd(":norm! viW")
    ts_builtin.grep_string({ cwd = vim.fn.expand("%:p:h") })
end

vim.keymap.set("n", "<leader>lf", find_local, nore("Search buffers directory for file"))
vim.keymap.set("n", "<leader>ls", srep_local, nore("Search buffers directory for string"))
vim.keymap.set("n", "<leader>lw", word_local, nore("Search buffers directory for word under cursor"))
vim.keymap.set("n", "<leader>lW", Word_local, nore("Search buffers directory for WORD under cursor"))


local function find_user()
    local dir = utils.query_directory("Find Files>")
    if not dir then return end
    if not utils.exists(dir) then
        vim.notify("Find Files Error: Could not open Directory \""..dir.."\"")
        return
    end
    ts_builtin.find_files({ cwd = dir })
end

local function srep_user()
    local dir = utils.query_directory("Live Grep>")
    if not dir then return end
    if not utils.exists(dir) then
        vim.notify("Live Grep Error: Could not open Directory \""..dir.."\"")
        return
    end
    ts_builtin.live_grep({ cwd = dir })
end

local function word_user()
    local dir = utils.query_directory("Grep Word>")
    if not dir then return end
    if not utils.exists(dir) then
        vim.notify("Grep Word Error: Could not open Directory \""..dir.."\"")
        return
    end
    ts_builtin.grep_string({ cwd = dir })
end

local function Word_user()
    local dir = utils.query_directory("Grep WORD>")
    if not dir then return end
    if not utils.exists(dir) then
        vim.notify("Grep WORD Error: Could not open Directory \""..dir.."\"")
        return
    end
    vim.cmd(":norm! viW")
    ts_builtin.grep_string({ cwd = dir })
end

vim.keymap.set("n", "<leader>uf", find_user, nore("Search provided directory for file"))
vim.keymap.set("n", "<leader>us", srep_user, nore("Search provided directory for string"))
vim.keymap.set("n", "<leader>uw", word_user, nore("Search provided directory for word under cursor"))
vim.keymap.set("n", "<leader>uW", Word_user, nore("Search provided directory for WORD under cursor"))


local cb_fuzzy = ts_builtin.current_buffer_fuzzy_find

local function find_inside()
    cb_fuzzy()
end

local function word_inside()
    local word = vim.fn.expand("<cword>") or ""
    cb_fuzzy()
    vim.cmd(":norm! i"..word)
end

local function Word_inside()
    local word = vim.fn.expand("<cWORD>") or ""
    cb_fuzzy()
    vim.cmd(":norm! i"..word)
end

vim.keymap.set("n", "<leader>is", find_inside, nore("Search current buffer for string"))
vim.keymap.set("n", "<leader>iw", word_inside, nore("Search current buffer for word under cursor"))
vim.keymap.set("n", "<leader>iW", Word_inside, nore("Search current buffer for WORD under cursor"))

----------------
-- Oil Config --
----------------
local oil = require("oil")
oil.setup({
    default_file_explorer = true,
    columns = { "icon", "permissions", "size" },
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
        concealcursor = "n",
    },
    restore_win_options = true,
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    prompt_save_on_select_new_entry = true,
    keymaps = {
        ["g?"] = "actions.show_help",
        ["<cr>"] = "actions.select",
        ["<leader>v"] = "actions.select_vsplit",
        ["<leader>V"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["g."] = "actions.toggle_hidden",
    },
    use_default_keymaps = false,
    preview = { border = "rounded" },
    view_options = { show_hidden = true },
})

local function view_project() oil.open(vim.fn.getcwd()) end
local function view_local() oil.open(vim.fn.expand("%:p:h")) end
local function view_user()
    local dir = utils.query_directory("Oil>")
    if not dir then return end
    if not utils.exists(dir) then
        vim.notify("Oil Error: Could not open Directory \""..dir.."\"")
        return
    end
    oil.open(dir)
end

vim.keymap.set("n", "<leader>pv", view_project, nore("Open Current Working Directory in Oil Buffer"))
vim.keymap.set("n", "<leader>lv", view_local, nore("Open Buffers directory in Oil Buffer"))
vim.keymap.set("n", "<leader>uv", view_user, nore("Open provided directory in Oil Buffer"))

-----------------------
-- Treesitter Config --
-----------------------
vim.filetype.add({ extension = { glsl = "glsl" } })
vim.filetype.add({ extension = { vert = "glsl" } })
vim.filetype.add({ extension = { tesc = "glsl" } })
vim.filetype.add({ extension = { tese = "glsl" } })
vim.filetype.add({ extension = { geom = "glsl" } })
vim.filetype.add({ extension = { frag = "glsl" } })
vim.filetype.add({ extension = { comp = "glsl" } })
vim.filetype.add({ extension = { comp = "glsl" } })

require("nvim-treesitter.configs").setup({
    ensure_installed = { "c", "lua", "vim", "vimdoc", "odin", "glsl" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, },
})

----------------
-- LSP Config --
----------------
local lspconfig = require("lspconfig")
require("lspconfig.ui.windows").default_options.border = "double"

lspconfig.ols.setup({})
lspconfig.glslls.setup({})
lspconfig.clangd.setup({})
lspconfig.jsonls.setup({})
lspconfig.bashls.setup({})
lspconfig.tsserver.setup({})
lspconfig.nim_langserver.setup({})
-- lsp.java_language_server.setup({})
lspconfig.jedi_language_server.setup({})
lspconfig.cmake.setup({})
lspconfig.html.setup({})
lspconfig.asm_lsp.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.cssls.setup({})
lspconfig.lua_ls.setup({
    on_init = function(client)
        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library"
                }
            }
        })
    end,
    settings = { Lua = {} }
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf,                 desc = "LSP: Goto Declaration" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf,                  desc = "LSP: Goto Definition" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf,              desc = "LSP: Goto Implementation" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf,                        desc = "LSP: Hover" })
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = ev.buf,      desc = "LSP: Get type definition" })
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = ev.buf,               desc = "LSP: Rename Symbol" })
        vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP: Attempt Code Action" })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf,                  desc = "LSP: Open symbol references" })
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = ev.buf,           desc = "LSP: Signature Help" })
    end,
})

local function toggle_lsp()
    if vim.lsp.get_clients({bufnr = 0}) then vim.cmd(":LspStop")
    else vim.cmd(":LspStart") end
end
vim.keymap.set("n", "gl", toggle_lsp, { noremap = true, silent = false, desc = "LSP: Toggle LSPs" })

local border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field, redefined-local
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end


-------------------------
-- Color Picker Config --
-------------------------
require("color-picker").setup({
    ["icons"] = { "█", "▓", },
    ["border"] = "rounded",
    ["background_highlight_group"] = "Normal",
    ["border_highlight_group"] = "FloatBorder",
    ["text_highlight_group"] = "Normal",
})
vim.keymap.set("n", "<leader>c", "<cmd>PickColor<cr>", nore("Select a color"))

------------------------
-- Icon Picker Config --
------------------------

require("icon-picker").setup({ disable_legacy_commands = true })
vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", nore("Open icon picker in insert mode"))
vim.keymap.set("n", "<leader>i", "<cmd>IconPickerNormal<cr>", nore("Open icon picker in normal mode"))

---------------------
-- Harpoon Config --
---------------------
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, nore("Open Harpoon UI"))
vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end, nore("Add current buffer to Harpoon list"))

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, nore("Open Harpoon buffer #0"))
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, nore("Open Harpoon buffer #1"))
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, nore("Open Harpoon buffer #2"))
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, nore("Open Harpoon buffer #3"))

-----------------------
-- Toggleterm Config --
-----------------------
local toggleterm = require("toggleterm")
toggleterm.setup({
    open_mapping = [[<C-\>]],
    hide_numbers = false,
    autochdir = false,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    direction = "tab",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    on_open = function()
        vim.opt_local.rnu = true
        vim.opt_local.nu = true
    end,
    float_opts = { border = "curved" },
})

vim.keymap.set("t", "<ESC>", "<cmd>stopinsert<cr>", nore("Exit insert mode while in a terminal"))

----------------
-- Cmp Config --
----------------
local luasnip = require("luasnip")
local cmp = require("cmp")

vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "NONE" })
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        {
            name = "spell",
            keep_all_entries = false,
            enable_in_context = function()
                return true
            end,
        },
    }),
    window = {
        completion = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:Boolean",
            col_offset = -3,
            side_padding = 0,
            border = "rounded",
        },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
})


----------------
-- DAP Config --
----------------
local dap = require("dap")
local dapw = require("dap.ui.widgets")

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data").."/mason/bin/codelldb",
        args = {"--port", "${port}"},
    },
}

local function dap_get_args()
    local userin = vim.fn.input("Arguments>").." "
    if #userin == 0 then return {} end

    local words = {}

    local inQuotes = false
    local word = ""
    local prev = ""
    for i = 1, #userin, 1 do
        local char = userin:sub(i, i)

        if char == " " and (inQuotes or prev == "\\") then
            word = word..char

        elseif char == " " and (not inQuotes or prev ~= "\\") then
            if #word ~= 0 then table.insert(words, #words + 1, word) end
            word = ""

        elseif char == "\\" then
            goto continue

        elseif char == "\"" and not inQuotes then
            inQuotes = true

        elseif char == "\"" and inQuotes then
            if #word ~= 0 then table.insert(words, #words + 1, word) end
            word = ""
            inQuotes = false

        else
            word = word..char

        end

        ::continue::
        prev = char
    end

    return words
end

dap.configurations.c = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input({
                prompt = "Path to executable: ",
                default = vim.fn.getcwd().."/",
                completion = "file",
            })
        end,
        args = function()
            local result = dap_get_args()
            vim.print(result)
            return result
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.odin = dap.configurations.c

local dapui = require("dapui")
dapui.setup({
    layouts = {
        {
            elements = { {
                id = "scopes",
                size = 0.25
            }, {
                id = "breakpoints",
                size = 0.25
            }, {
                id = "stacks",
                size = 0.25
            }, {
                id = "watches",
                size = 0.25
            } },
            position = "left",
            size = 40
        }, {
            elements = { {
                id = "console",
                size = 0.5
            }, {
                id = "repl",
                size = 0.5
            } },
            position = "bottom",
            size = 10
        },
    },
})

dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config     = dapui.close


vim.keymap.set("n", "<leader>go", dapui.toggle, { desc = "Toggle Debugger UI" })
vim.keymap.set("n", "<leader>gu", function() dapui.open({ reset = true }) end, { desc = "Reset Debugger UI" })
-- vim.keymap.set("n", "<leader>gr", dap.repl.open, { desc = "" })
vim.keymap.set("n", "<leader>gl", dap.run_last, { desc = "Run previous Debugger" })

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Debugger breakpoint on current line" })
vim.keymap.set("i", "<C-b>", dap.toggle_breakpoint, { desc = "Toggle Debugger breakpoint on current line in insert mode" })

vim.keymap.set("n", "<leader>k", dapw.hover, { desc = "Toggle Debugger hover (buggy)" })

vim.keymap.set("n", "<S-F5>", dap.terminate, { desc = "Terminate the current Debugger" })
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue current Debugger" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over to next line in current Debugger" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into to next function in current Debugger" })

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg=0, fg="RED", bg="none" })
vim.fn.sign_define("DapBreakpoint", {text="", texthl="DapBreakpoint", linehl="", numhl=""})
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { ctermbg=0, fg="YELLOW", bg="none" })
vim.fn.sign_define("DapBreakpointCondition", {text="", texthl="DapBreakpointCondition", linehl="", numhl=""})
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg=0, fg="GREEN", bg="none" })
vim.fn.sign_define("DapStopped", {text="⇥", texthl="DapStopped", linehl="", numhl=""})

----------------
-- Hex Config --
----------------------------------------
require("hex").setup({})
