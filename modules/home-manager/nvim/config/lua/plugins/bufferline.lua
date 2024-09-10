return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or ""
					return icon .. " " .. count
				end,
				style_preset = {
					bufferline.style_preset.minimal,
				},
				numbers = "ordinal",
				groups = {
					items = {
						require("bufferline.groups").builtin.pinned:with({ icon = "" }),
					},
				},
				show_buffer_close_icons = false,
				show_close_icon = false,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
			},
		})
		vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>pin", ":BufferLineTogglePin<CR>", { noremap = true, silent = true })

		-- https://vi.stackexchange.com/questions/44617/bufferline-in-nvim-auto-close-or-hide-no-name-buffer-when-other-buffers-are-o
		-- Function to close empty and unnamed buffers
		---@diagnostic disable-next-line: lowercase-global
		function close_empty_unnamed_buffers()
			-- Get a list of all buffers
			local buffers = vim.api.nvim_list_bufs()

			-- Iterate over each buffer
			for _, bufnr in ipairs(buffers) do
				-- Check if the buffer is empty and doesn't have a name
				if
					vim.api.nvim_buf_is_loaded(bufnr)
					and vim.api.nvim_buf_get_name(bufnr) == ""
					and vim.api.nvim_buf_get_option(bufnr, "buftype") == ""
				then
					-- Get all lines in the buffer
					local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

					-- Initialize a variable to store the total number of characters
					local total_characters = 0

					-- Iterate over each line and calculate the number of characters
					for _, line in ipairs(lines) do
						total_characters = total_characters + #line
					end

					-- Close the buffer if it's empty:
					if total_characters == 0 then
						vim.api.nvim_buf_delete(bufnr, {
							force = true,
						})
					end
				end
			end
		end

		-- Clear the mandatory, empty, unnamed buffer when a real file is opened:
		vim.api.nvim_command("autocmd BufReadPost * lua close_empty_unnamed_buffers()")
	end,
}
