function P(thing)
    vim.print(thing)
end

package.path = package.path .. ";"..vim.fn.stdpath("config").."/?.lua"
require("set")
require("remap")
require("status-line")
require("lazy-pkgman")
require("terminal")

vim.cmd(":colorscheme mel-desert")

vim.g.netrw_banner = false
vim.g.asmsyntax = "fasm"
vim.filetype.add({
    extension = {
        fanfic = "fanfic",
        ff     = "fanfic",
    },
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.h"},
    callback = function()
        vim.bo.filetype = "c"
    end,
})

