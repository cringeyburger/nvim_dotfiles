return {
	"phaazon/hop.nvim",
	config = function()
		local hop = require("hop")

		hop.setup()

		vim.api.nvim_set_keymap("n", "<leader>hf", "<cmd>HopChar1CurrentLineAC<CR>", {})
		vim.api.nvim_set_keymap("n", "<leader>hF", "<cmd>HopChar1CurrentLineBC<CR>", {})
		vim.api.nvim_set_keymap("n", "<leader>ht", "<cmd>HopChar1CurrentLineAC<CR>", {})
		vim.api.nvim_set_keymap("n", "<leader>hT", "<cmd>HopChar1CurrentLineBC<CR>", {})
		vim.api.nvim_set_keymap("n", "<leader>hs", "<cmd>HopChar2AC<CR>", {})
		vim.api.nvim_set_keymap("n", "<leader>hS", "<cmd>HopChar2BC<CR>", {})
	end,
}
