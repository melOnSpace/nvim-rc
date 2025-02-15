local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"

local utils = require("utils")

if #vim.fn.finddir(lazypath) <= 0 then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local fanfic_plugin

-- if vim.fn.has("linux") ~= 0 then
-- elseif vim.fn.has("win32") ~= 0 then
-- else then error("unsupported os") end


if vim.fn.has("linux") ~= 0 then
    fanfic_plugin = { dir = utils.HOMEDIR.."/prog/nvim/nvim-fanfic", dependencies = "nvim-telescope/telescope.nvim" }
elseif vim.fn.has("win32") ~= 0 then
    fanfic_plugin = { dir = "C:\\prog\\nvim\\nvim-fanfic", dependencies = "nvim-telescope/telescope.nvim" }
else
    error("unsupported os"); return
end

local plugins = {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("dracula").setup({
                colors = { bg = "#151515" },
                italic_comment = false,
                show_end_of_buffer = true,
                transparent_bg = true,
                overrides = {
                    Type = { fg="White" },
                    ColorColumn = { bg="#202020" },
                },
            })
            vim.cmd("colorscheme dracula-soft")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                enable = { terminal = true },
                styles = { bold = true, italic = false, transparency = false },
                disable_background = true,
            })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "ziontee113/icon-picker.nvim",
        dependencies = { "stevearc/dressing.nvim" },
        config = function()
            require("icon-picker").setup({ disable_legacy_commands = true })
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
        }
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                "!fanfic",
            })
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
        config = function()
            require("render-markdown").setup({})
        end,
    },
    {
        "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker").setup({
                ["icons"] = { "█", "▓", },
                ["border"] = "single",
                ["background_highlight_group"] = "Normal",
                ["border_highlight_group"] = "FloatBorder",
                ["text_highlight_group"] = "Normal",
            })
        end,
    },
    {
        "RaafatTurki/hex.nvim",
        config = function()
            require("hex").setup({})
        end,
    },

    "hrsh7th/nvim-cmp",
    "ray-x/cmp-treesitter",
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",
    "Eandrju/cellular-automaton.nvim",
    "akinsho/toggleterm.nvim",
    "mfussenegger/nvim-dap",
}

if vim.fn.has("linux") then
    table.insert(plugins, fanfic_plugin)
end

local opts = {
    root = vim.fn.stdpath("data").."/lazy",
    dev = { path = "~/prog/nvim" },
    install = {
        missing = true,
        colorscheme = { "dracula" },
    },
    ui = {
        border = "double",
        title = "Lazy Package Manager",
        title_pos = "center",
        pills = true,
        icons = {
            cmd = " ",
            config = "",
            event = "",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            source = " ",
            start = "",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
        browser = "librewolf",
        throttle = 20,
        custom_keys = { },
    },
    checker = {
        enabled = false,   -- automatically check for plugin updates
        concurrency = nil, -- set to 1 to check for updates very slowly
        notify = true,     -- get a notification when new updates are found
        frequency = 3600,  -- check for updates every n seconds
    },
    change_detection = {
        enabled = true, -- automatically check for config file changes and reload the ui
        notify = true,  -- get a notification when changes are found
    },
    performance = {
        cache = { enabled = true },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {}, -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            disabled_plugins = {
            --     "gzip",
            --     "matchit",
            --     "matchparen",
            --     "netrwPlugin",
            --     "tarPlugin",
            --     "tohtml",
            --     "tutor",
            --     "zipPlugin",
            },
        },
    },
}

require("lazy").setup(plugins, opts)
