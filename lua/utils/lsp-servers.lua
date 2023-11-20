local M = {}

M.all_servers = {
	-- "jsonls",
	"lua_ls",
	"clangd",
	"cmake",
	"pyright",
	"html",
	"prosemd_lsp",
	"cssls",
	"rust_analyzer",
	"jedi_language_server",
	"vuels",
	"tsserver",
	"texlab",
	"angularls",
	"eslint",
	--"gopls",
	"astro",
}

M.regular_servers = {
	"cmake",
	"prosemd_lsp",
	"cssls",
	"jedi_language_server",
	"vuels",
	"tsserver",
	"texlab",
	"angularls",
	"eslint",
	--"gopls",
	"clangd",
	"lua_ls",
	"pyright",
	"astro",
}

return M
