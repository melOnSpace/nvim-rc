function P(thing)
    vim.print(thing)
end

---@diagnostic disable-next-line: param-type-mismatch
package.path = package.path .. ";"..vim.fn.stdpath("config").."/?.lua"
require("set")
require("remap")
require("status-line")
require("lazy-pkgman")

vim.cmd(":colorscheme mel-desert")

vim.g.netrw_banner = false

