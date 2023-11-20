return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local lualine = require("lualine")
        local tokyonight = require("tokyonight")
        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand("%:p:h")
                local gitdir = vim.fn.finddir(".git", filepath .. ";")
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }
        local colors = {
            tokyonight_moon = {
                bg = "#222436",
                fg = "#c8d3f5",
                yellow = "#ffc777",
                cyan = "#86e1fc",
                darkblue = "#82aaff",
                green = "#c3e88d",
                orange = "#ff966c",
                magenta = "#c099ff",
                blue = "#394b70",
                red = "#ff757f",
            },
            catppuccin_mocha = {
                bg = "#1E1E2E",
                fg = "#CDD6F4",
                yellow = "#F9E2AF",
                cyan = "#7fdbca",
                darkblue = "#89B4FA",
                green = "#A6E3A1",
                orange = "#e3d18a",
                violet = "#a9a1e1",
                magenta = "#ae81ff",
                blue = "#89B4FA",
                red = "#F38BA8",
            },
        }

        colors = colors.tokyonight_moon

        local config = {
            options = {
                icons_enabled = true,
                global_status = true,
                component_separators = "",
                section_separators = "",
                disabled_filetypes = { "alpha", "dashboard", "Outline" },
                always_divide_middle = true,
                theme = "tokyonight",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_y = {},
                lualine_z = { "location" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
            },
            tabline = {},
            extensions = {},
        }
        lualine.setup(config)
    end,
}
