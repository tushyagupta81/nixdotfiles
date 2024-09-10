vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.clipboard = "unnamedplus"
-- vim.api.nvim_set_option("clipboard", "unnamed")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim.keymap.set("n", "<leader>cb", ":w<CR>:bd<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":w<CR>:bp<bar>sp<bar>bn<bar>bd<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>wqa", ":wa<CR>:qa<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-w>+", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "<C-w>-", [[<cmd>horizontal resize -2<cr>]])

vim.keymap.set({ "n", "v" }, ";", "$")

-- <C-r><C-w> gets the curret word under cursor
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]])
