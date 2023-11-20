return {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local nls = require("null-ls")
        local fmt = nls.builtins.formatting
        local dgn = nls.builtins.diagnostics
        local cda = nls.builtins.code_actions

        nls.setup({
            sources = {
                ----------------
                -- FORMATTING --
                ----------------
                fmt.trim_whitespace.with({
                    filetypes = { "text", "zsh", "toml", "make", "conf", "tmux" },
                }),
                -- NOTE:
                -- 1. both needs to be enabled to so prettier can apply eslint fixes
                -- 2. prettierd should come first to prevent occassional race condition
                fmt.prettierd,
                fmt.prettier,
                fmt.eslint_d,
                fmt.clang_format,
                -- fmt.prettier.with({
                --     extra_args = {
                --         '--tab-width=4',
                --         '--trailing-comma=es5',
                --         '--end-of-line=lf',
                --         '--arrow-parens=always',
                --     },
                -- }),
                fmt.rustfmt,
                --fmt.autoflake,
                fmt.black,
                fmt.isort,
                fmt.stylua,
                fmt.gofmt,
                fmt.zigfmt,
                fmt.shfmt.with({
                    extra_args = { "-i", 4, "-ci", "-sr" },
                }),
                -----------------
                -- DIAGNOSTICS --
                -----------------
                dgn.eslint_d,
                dgn.shellcheck,
                dgn.luacheck.with({
                    extra_args = { "--globals", "vim", "--std", "luajit" },
                }),
                dgn.cppcheck,
                dgn.cpplint,
                dgn.pylint,
                dgn.revive,
                dgn.flake8,
                ------------------
                -- CODE ACTIONS --
                ------------------
                cda.eslint_d,
                cda.shellcheck,
                cda.impl,
            },
            --on_attach = function(client, bufnr)
            --    U.fmt_on_save(client, bufnr)
            --    U.mappings(bufnr)
            --end,
            on_attach = require("plugins.lsp.handlers").on_attach,
        })
    end,
}
