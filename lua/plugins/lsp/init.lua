return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"p00f/clangd_extensions.nvim",
		"simrat39/rust-tools.nvim",
	},
	config = function()
		require("plugins.lsp.handlers").setup()
		require("plugins.lsp.config")
	end,
}
