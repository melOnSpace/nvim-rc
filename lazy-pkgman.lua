-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = { { import = "lazy-plugs" }, --[[ import your plugins ]] },
    install = { colorscheme = { "mel-desert" } },
    checker = { enabled = true }, -- automatically check for plugin updates
    ui = { border = "single" },
    pills = true, ---@type boolean
    performance = {
        cache = { enabled = true },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            disabled_plugins = {
                "gzip", "matchit", "matchparen",
                "netrwPlugin", "tarPlugin", "tohtml",
                "tutor", "zipPlugin",
            },
        },
    },
})

