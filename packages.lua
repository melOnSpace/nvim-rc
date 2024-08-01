local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: deprecated
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
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
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "double",
                },
            })
        end,
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
        "Vonr/align.nvim",
        branch = "v2",
    },

    "folke/neodev.nvim",
    "Eandrju/cellular-automaton.nvim",
    "mfussenegger/nvim-dap",

    "akinsho/toggleterm.nvim",
    "NeogitOrg/neogit",
    "f3fora/cmp-spell",

    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "RaafatTurki/hex.nvim",

    "ziontee113/color-picker.nvim",

    {
        dir = "/home/mel/prog/lua/dico-client-modded",
        priority = 0,
    },
}

local opts = {
    root = vim.fn.stdpath("data") .. "/lazy",
    dev = {
        -- directory where you store your local plugin projects
        path = "~/prog/nvim",
    },
    install = {
        -- install missing plugins on startup. This doesn't increase startup time.
        missing = true,
        -- try to load one of these colorschemes when starting an installation during startup
        colorscheme = { "dracula" },
    },
    ui = {
        border = "double",
        title = "Lazy Package Manager", ---@type string only works when border is not "none"
        title_pos = "center", ---@type "center" | "left" | "right"
        -- Show pills on top of the Lazy window
        pills = true, ---@type boolean
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

        browser = nil, ---@type string?
        throttle = 20, -- how frequently should the ui process render events
        custom_keys = {
            ["<localleader>l"] = function(plugin)
                require("lazy.util").float_term({ "lazygit", "log" }, {
                    cwd = plugin.dir,
                })
            end,

            -- open a terminal for the plugin dir
            ["<localleader>t"] = function(plugin)
                require("lazy.util").float_term(nil, {
                    cwd = plugin.dir,
                })
            end,
        },
    },
    checker = {
        -- automatically check for plugin updates
        enabled = false,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true, -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = true, -- get a notification when changes are found
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            ---@type string[]
            paths = {}, -- add any custom paths here that you want to includes in the rtp
            ---@type string[] list any plugins you want to disable here
            -- disabled_plugins = {
            --     "gzip",
            --     "matchit",
            --     "matchparen",
            --     "netrwPlugin",
            --     "tarPlugin",
            --     "tohtml",
            --     "tutor",
            --     "zipPlugin",
            -- },
        },
    },
}

require("lazy").setup(plugins, opts)
