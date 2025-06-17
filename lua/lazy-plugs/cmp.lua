local function cmp_config()
    require("cmp").setup({
        snippet = {},
        completion = {
            autocomplete = false,
        },
        sources = require("cmp").config.sources({
            { name = "treesitter", completion = { autocomplete = false } },
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
        mapping = require("cmp").mapping.preset.insert({
            ["<C-F>"] = require("cmp").mapping.scroll_docs(-4),
            ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
            ["<C-Space>"] = require("cmp").mapping.abort(),
            ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
        }),
    })
end

return {
    {
        "hrsh7th/nvim-cmp",
        config = cmp_config,
    },
    "ray-x/cmp-treesitter",
    "f3fora/cmp-spell",
}
