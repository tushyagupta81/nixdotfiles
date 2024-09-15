return {
	"vim-test/vim-test",
	event = "VeryLazy",
	enabled = false,
	dependencies = {
		"preservim/vimux",
	},
	vim.keymap.set("n", "<leader>t", ":TestNearest<CR>"),
	vim.keymap.set("n", "<leader>T", ":TestFile<CR>"),
	-- FIXME <leader>a is used
	-- vim.keymap.set("n", "<leader>a", ":TestSuite<CR>"),
	vim.keymap.set("n", "<leader>l", ":TestLast<CR>"),
	vim.keymap.set("n", "<leader>g", ":TestVisit<CR>"),
	vim.cmd('let test#strategy = "vimux"'),
}
