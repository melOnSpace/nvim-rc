-- local function treesitter_config()
--     require("nvim-treesitter.configs").setup({
--         ensure_installed = { "markdown", "markdown_inline", "c", "odin", "lua" },
--         sync_install = false,
--         auto_install = true,
--         -- ignore_install = { "all" },
--
--         highlight = {
--             enable = true,
--             disable = function(lang, buf)
--                 return not (lang == "markdown" or lang == "markdown_inline")
--             end,
--             additional_vim_regex_highlighting = false,
--         },
--     })
-- end

local function harpoon2_config()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<M-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
end

return {
    "RRethy/nvim-align",
    "Eandrju/cellular-automaton.nvim",
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     build = ":TSUpdate",
    --     config = treesitter_config,
    -- },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = harpoon2_config,
    },
    {
        "ziontee113/icon-picker.nvim",
        dependencies = { "stevearc/dressing.nvim" },
        config = function()
            require("icon-picker").setup({ disable_legacy_commands = true })
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
        config = function()
            require("render-markdown").setup({})
            vim.keymap.set("n", "gb", function()require("render-markdown").toggle()end, {noremap=true,silent=true,desc="Toggle Markdown Rendering"})
        end,
    },
    {
        "RaafatTurki/hex.nvim",
        config = function()
            require("hex").setup({})
        end,
    },
}

-- local function cmp_config()
--     require("cmp").setup({
--         snippet = {},
--         completion = {
--             autocomplete = false,
--         },
--         sources = require("cmp").config.sources({
--             { name = "treesitter", completion = { autocomplete = true } },
--             {
--                 name = "spell",
--                 keep_all_entries = false,
--                 enable_in_context = function()
--                     return true
--                 end,
--             },
--         }),
--         window = {
--             completion = {
--                 winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:Boolean",
--                 col_offset = -3,
--                 side_padding = 0,
--                 border = "rounded",
--             },
--         },
--         mapping = require("cmp").mapping.preset.insert({
--             ["<C-F>"] = require("cmp").mapping.scroll_docs(-4),
--             ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
--             ["<C-Space>"] = require("cmp").mapping.abort(),
--             ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
--         }),
--     })
-- end
--
-- return {
--     {
--         "hrsh7th/nvim-cmp",
--         config = cmp_config,
--     },
--     "ray-x/cmp-treesitter",
--     "f3fora/cmp-spell",
-- }
