return {
	"ziontee113/icon-picker.nvim",
	dependencies = {
		"stevearc/dressing.nvim",
	},
	config = function()
		local icon = require("icon-picker")
		icon.setup({
			disable_legacy_commands = true,
		})
	end,
}
