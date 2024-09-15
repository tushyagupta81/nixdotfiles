return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
	config = function()
		local neogit = require("neogit")

		neogit.setup({
			-- "ascii"   is the graph the git CLI generates
			-- "unicode" is the graph like https://github.com/rbong/vim-flog
			graph_style = "unicode",
			signs = {
				-- { CLOSED, OPENED }
				hunk = { "", "" },
				item = { "⇢", "⇣" },
				section = { "⇢", "⇣" },
			},
			-- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
			integrations = {
				-- If enabled, use telescope for menu selection rather than vim.ui.select.
				-- Allows multi-select and some things that vim.ui.select doesn't.
				telescope = true,
				-- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
				-- The diffview integration enables the diff popup.
				--
				-- Requires you to have `sindrets/diffview.nvim` installed.
				diffview = true,

				-- If enabled, uses fzf-lua for menu selection. If the telescope integration
				-- is also selected then telescope is used instead
				-- Requires you to have `ibhagwan/fzf-lua` installed.
				fzf_lua = true,
			},
			mappings = {
				status = {
					["-"] = "Toggle",
				},
			},
		})
		vim.keymap.set("n", "<leader>ng", "<cmd>Neogit<CR>", {})
		vim.keymap.set("n", "<leader>nd", "<cmd>Neogit diff<CR>", {})
	end,
}
