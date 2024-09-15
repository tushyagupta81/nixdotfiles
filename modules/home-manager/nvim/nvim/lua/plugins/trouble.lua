return {
	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		config = function()
			require("trouble").setup({})

			vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>")

			vim.keymap.set("n", "[t", function()
				require("trouble").next({ skip_groups = true, jump = true })
			end)

			vim.keymap.set("n", "]t", function()
				require("trouble").prev({ skip_groups = true, jump = true })
			end)

			vim.keymap.set("n", "<leader>xq", function()
				require("trouble").toggle("quickfix")
			end)
		end,
	},
}
