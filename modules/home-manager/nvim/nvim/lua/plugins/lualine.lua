return {
	"nvim-lualine/lualine.nvim",
	config = function()
		if vim.g.colors_name == "cyberdream" then
			local cyberdream = require("lualine.themes.cyberdream")
			require("lualine").setup({
				options = {
					theme = "cyberdream",
				},
			})
		else
			require("lualine").setup({
				options = {
					theme = "ayu_mirage",
				},
			})
		end
	end,
}
