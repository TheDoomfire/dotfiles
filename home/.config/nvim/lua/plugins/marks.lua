return {
    {
        -- Just shows marks in the signcolumn
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        -- Insolated [M]arks per project.
        "mohseenrm/marko.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("marko").setup()
        end,
    },
}
