return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local barbar = require("barbar")
        vim.g.barbar_auto_setup = false
        barbar.setup({
            opts = {},
        })
    end,
}
