return {
	"ahmedkhalf/project.nvim",
	config = function()
		local telescope = require("telescope")
		local project = require("project_nvim")
		project.setup({
			active = true,
			on_config = nil,
			manual_mode = false,
			detection_methods = { "pattern" },
			patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
			show_hidden = true,
			silent_chdir = true,
			ignore_lsp = {},
			datapath = vim.fn.stdpath("data"),
		})
		telescope.load_extension("projects")
	end,
}
