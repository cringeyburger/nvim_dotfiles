local M = {}

local icons = require("config.icons")
local fmt_group = vim.api.nvim_create_augroup("FORMATTING", { clear = true })

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    local config = {
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })

    -- suppress error messages from lang servers
    vim.notify = function(msg, log_level)
        if msg:match("exit code") then
            return
        end
        if log_level == vim.log.levels.ERROR then
            vim.api.nvim_err_writeln(msg)
        else
            vim.api.nvim_echo({ { msg } }, true, {})
        end
    end
end

local function lsp_highlight_document(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", {
            clear = false,
        })
        vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = "lsp_document_highlight",
        })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

local function lsp_keymaps(bufnr)
    local keymap = function(mode, key, action)
        vim.keymap.set(mode, key, action, { buffer = bufnr })
    end

    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like "open vsplit",
    -- you can use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

    -- Code action
    keymap({ "n", "v" }, "lca","<cmd>Lspsaga code_action<CR>")

    -- Rename all occurrences of the hovered word for the entire file
    keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

    -- Rename all occurrences of the hovered word for the selected files
    keymap("n", "gR", "<cmd>Lspsaga rename ++project<CR>")

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "gD", "<cmd>Lspsaga peek_definition<CR>")

    -- Go to definition
    keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "gT", "<cmd>Lspsaga peek_type_definition<CR>")

    -- Go to type definition
    keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")

    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- Show cursor diagnostics
    -- Like show_line_diagnostics, it supports passing the ++unfocus argument
    keymap("n", "<leader>lc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

    -- Show buffer diagnostics
    keymap("n", "<leader>lb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    -- Diagnostic jump with filters such as only jumping to an error
    keymap("n", "[e", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    keymap("n", "]e", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)

    -- Toggle outline
    keymap("n", "<leader>lo", "<cmd>Lspsaga outline<CR>")

    -- If you want to keep the hover window in the top right hand corner,
    -- you can pass the ++keep argument
    -- Note that if you use hover with ++keep, pressing this key again will
    -- close the hover window. If you want to jump to the hover window
    -- you should use the wincmd command "<C-w>w"
end

local function fmt_on_save(client, buf)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = fmt_group,
            buffer = buf,
            callback = function()
                vim.lsp.buf.format({
                    timeout_ms = 3000,
                    buffer = buf,
                })
            end,
        })
    end
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client, bufnr)
    fmt_on_save(client, bufnr)
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local cmp_capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

cmp_capabilities.textDocument.semanticHighlighting = true
cmp_capabilities.offsetEncoding = "utf-8"
cmp_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

M.capabilities = cmp_capabilities

return M
