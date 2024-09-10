return {
	"lukas-reineke/indent-blankline.nvim",
	event = "VeryLazy",
	main = "ibl",
	opts = {},
	config = function()
		local highlight = {
			-- "CursorColumn",
			"Whitespace",
			"NonText",
		}
		require("ibl").setup({
			indent = { highlight = highlight },
			whitespace = {
				highlight = highlight,
				remove_blankline_trail = false,
			},
			scope = { enabled = true, highlight = { "Function", "Label" } },
		})
	end,
}
