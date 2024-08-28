vim.g.mapleader = " "

vim.keymap.set("t", "<ESC>", "<cmd>stopinsert<cr>", { noremap=true, silent=true, desc="Exit insert mode while in a terminal" })
vim.keymap.set("i", "<Tab>", "<Tab>", { desc = "Set <Tab> to itself (by default it is an alias for <C-i>" })
vim.keymap.set("n", "<leader>;", "q:", { noremap = true, desc = "Opens command mode in a buffer" })
vim.keymap.set("n", "{", ":keepj norm! {<cr>", { noremap=true, silent = true, desc = "Goto end of paragraph but keep jumps" })
vim.keymap.set("n", "}", ":keepj norm! }<cr>", { noremap=true, silent = true, desc = "goto start of paragraph but keep jumps" })

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Moves the line down one in visual mode" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Moves the line up one in visual mode" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Bring next line up to the current line" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move cursor down 50% and center buffer on cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move cursor up 50% and center buffer on cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Goto next highlight and center buffer on cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Goto previous highlight and center buffer on cursor" })

vim.keymap.set({"n", "v"}, "<M-y>", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({"n", "v"}, "<M-Y>", [["+Y]], { desc = "Yank up to whitespace to system clipboard" })
vim.keymap.set({"n", "v"}, "<M-p>", [["+p]], { desc = "Paste system clipboard" })
vim.keymap.set({"n", "v"}, "<M-P>", [["+P]], { desc = "Paste behind from system clipboard" })

vim.keymap.set({"n", "v"}, "<M-d>", [["_d]],  { desc = "'d' key but sends deleted contents to void register" })
vim.keymap.set({"n", "v"}, "<M-D>", [["_D]],  { desc = "'d' key but sends deleted contents to void register" })
vim.keymap.set({"n", "v"}, "<M-c>", [["_c]],  { desc = "'c' key but sends deleted contents to void register" })
vim.keymap.set({"n", "v"}, "<M-C>", [["_C]],  { desc = "'C' key but sends deleted contents to void register" })
vim.keymap.set({"n", "v"}, "<M-s>", [["_s]],  { desc = "'s' key but sends deleted contents to void register" })
vim.keymap.set({"n", "v"}, "<M-S>", [["_S]],  { desc = "'S' key but sends deleted contents to void register" })

vim.keymap.set("n", "Q", "@j", { desc = "Run j register" })
vim.keymap.set("x", "Q", ":norm @j<cr>", { desc = "Run j register but in visual modes" })

vim.keymap.set("n", "<M-,>", "<C-w><", { desc = "Grow current window to the left" })
vim.keymap.set("n", "<M-.>", "<C-w>>", { desc = "Grow current window to the right" })
vim.keymap.set("n", "<M-]>", "<C-w>+", { desc = "Grow current window upwards" })
vim.keymap.set("n", "<M-[>", "<C-w>-", { desc = "Grow current window downwards" })
vim.keymap.set("n", "<M-=>", "<C-w>=", { desc = "Make all windows equal size" })

vim.keymap.set("n", "<leader>w", function()
    vim.cmd([[:set invlist]])
    if vim.o.list then P("View Whitespace Enabled")
    else P("View Whitespace Disabled") end
end, { desc = "Toggle visible whitespace characters" })

vim.keymap.set("n", "<leader>s", function()
    vim.cmd([[:set invspell]])
    if vim.o.spell then P("Spelling Enabled for language \""..(vim.o.spelllang or "nil".."\""))
    else P("Spelling Disabled") end
end, { desc = "Toggle spelling" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic in float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
vim.keymap.set("n", "<C-k>", ":norm [dzz<cr>", { desc = "Goto previous diagnostic and center" })
vim.keymap.set("n", "<C-j>", ":norm ]dzz<cr>", { desc = "Goto next diagnostic and center" })


