local options = {
	termguicolors = true,

	-- Decrease update time
	timeoutlen = 500,
	updatetime = 200,

	-- Number of screen lines to keep above and below cursor
	scrolloff = 8,

	-- Better UI settings
	number = true,
	numberwidth = 5,
	relativenumber = true,
	signcolumn = "yes:1",
	cursorline = true,
	title = true,

	-- Better editing
	expandtab = true,
	cmdheight = 3,
	fileencoding = "utf-8",
	hlsearch = true,
	mouse = "a",
	pumheight = 10,
	showtabline = 2,
	smartindent = true,
	linebreak = true,
	sidescrolloff = 8,
	guifont = "FiraCode Nerd Font:h14",
	cindent = true,
	wrap = true,
	textwidth = 310,
	tabstop = 4,
	shiftwidth = 0,
	softtabstop = -1,
	list = true,
	listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂",
	clipboard = "unnamedplus",
	ignorecase = true,
	smartcase = true,
	incsearch = true,
	conceallevel = 0,
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	autoread = true,
	splitkeep = "screen",
	shortmess = "filnxtToOFWIcC",
	errorbells = false,
	showmode = false,
	fillchars = {
		diff = "",
		fold = " ",
		eob = " ",
		horiz = "━",
		horizup = "┻",
		horizdown = "┳",
		vert = "┃",
		vertleft = "┫",
		vertright = "┣",
		verthoriz = "╋",
		foldclose = "",
		foldopen = "",
		foldsep = " ",
	},
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.rust_recommended_style = false
