local lspconfig = require("lspconfig")
local lsp_servers = require("utils.lsp-servers")

local on_attach = require("plugins.lsp.handlers").on_attach
local capabilities = require("plugins.lsp.handlers").capabilities

for _, server in ipairs(lsp_servers.regular_servers) do
	lspconfig[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
