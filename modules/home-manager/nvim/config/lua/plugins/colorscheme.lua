-- return {
--     'catppuccin/nvim',
--     name = 'catppuccin',
--     priority = 1000,
--     config = function()
--         require('catppuccin').setup({
--             transparent_background = true,
--         })
--         vim.cmd.colorscheme "catppuccin-mocha"
--     end
-- }

-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		require("rose-pine").setup({
-- 			styles = {
-- 				italic = false,
-- 				transparency = true,
-- 			},
-- 		})
-- 		vim.cmd("colorscheme rose-pine-moon")
-- 	end,
-- }

return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			-- Enable transparent background
			transparent = true,
			borderless_telescope = false,
		})
		vim.cmd("colorscheme cyberdream")
	end,
}

-- return {
-- 	"diegoulloao/neofusion.nvim",
-- 	name = "neofusion",
-- 	priority = 1000,
-- 	config = function()
-- 		require("neofusion").setup({
-- 			transparent_mode = true,
-- 		})
-- 		vim.cmd.colorscheme("neofusion")
-- 	end,
-- }

-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	name = "kanagawa",
-- 	priority = 1000,
-- 	config = function()
-- 		require("kanagawa").setup({
-- 			transparent = true,
-- 			colors = {
-- 				theme = {
-- 					all = {
-- 						ui = {
-- 							bg_gutter = "none",
-- 						},
-- 					},
-- 				},
-- 			},
-- 		})
-- 		vim.cmd("colorscheme kanagawa-wave")
-- 	end,
-- }
