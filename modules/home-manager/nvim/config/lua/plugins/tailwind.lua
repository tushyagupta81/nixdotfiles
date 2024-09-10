-- return {
-- 	"roobert/tailwindcss-colorizer-cmp.nvim",
-- 	-- optionally, override the default options:
-- 	config = function()
-- 		require("tailwindcss-colorizer-cmp").setup({
-- 			color_square_width = 2,
-- 		})
-- 	end,
-- }
return {
	"luckasRanarison/tailwind-tools.nvim",
	event = "VeryLazy",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- optional
	},
	opts = {},
}
