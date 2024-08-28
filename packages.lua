local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"

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

local plugins = {
    {
        "Mofiqul/dracula.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("dracula").setup({
                colors = {
                    bg           = "#282A36", fg             = "#F8F8F2",
                    selection    = "#44475A", comment        = "#8590c2",
                    red          = "#FF5555", orange         = "#FFB86C",
                    yellow       = "#F1FA8C", green          = "#50fa7b",
                    purple       = "#BD93F9", cyan           = "#8BE9FD",
                    pink         = "#FF79C6", bright_red     = "#FF6E6E",
                    bright_green = "#69FF94", bright_yellow  = "#FFFFA5",
                    bright_blue  = "#D6ACFF", bright_magenta = "#FF92DF",
                    bright_cyan  = "#A4FFFF", bright_white   = "#FFFFFF",
                    menu         = "#21222C", visual         = "#3E4452",
                    gutter_fg    = "#4B5263", nontext        = "#3B4048",
                    white        = "#ABB2BF", black          = "#191A21",
                },
                show_end_of_buffer = true,
                transparent_bg = true,
                overrides = {
                    NormalFloat     = { bg = nil },
                    TelescopeNormal = { bg = nil },
                    SpecialKey      = { bg = nil, fg="#ff92df" },
                },
            })

            vim.cmd("colorscheme dracula")
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
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "U", vim.cmd.UndotreeToggle, { noremap = true, desc = "Toggle UndoTree" })
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
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
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({ ui = { border = "single" }, })
        end,
    },

    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",

    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",

    "Eandrju/cellular-automaton.nvim",
    "folke/neodev.nvim",
    "akinsho/toggleterm.nvim",
    "mfussenegger/nvim-dap",
}

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
                "tutor",
            --     "zipPlugin",
            },
        },
    },
}

require("lazy").setup(plugins, opts)
