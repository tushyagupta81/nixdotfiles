return { -- Collection of various small independent plugins/modules
	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			-- local statusline = require("mini.statusline")
			-- -- set use_icons to true if you have a Nerd Font
			-- statusline.setup({ use_icons = true })
			--
			-- -- You can configure sections in the statusline by overriding their
			-- -- default behavior. For example, here we set the section for
			-- -- cursor location to LINE:COLUMN
			-- ---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			-- 	return "%2l:%-2v"
			-- end
			require("mini.indentscope").setup({
				draw = {
					delay = 100,
					priority = 2,
					animation = function(s, n)
						return s / n * 20
					end,
				},
			})

			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),

					hsl_color = {
						pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
						group = function(_, match)
							local utils = require("plugins.utils.hsl")
							--- @type string, string, string
							local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
							--- @type number?, number?, number?
							local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
							--- @type string
							---@diagnostic disable-next-line: param-type-mismatch
							local hex_color = utils.hslToHex(h, s, l)
							return hipatterns.compute_hex_color_group(hex_color, "bg")
						end,
					},
				},
			})

			require("mini.starter").setup()
		end,
	},
	{
		"echasnovski/mini.icons",
		opts = {},
		lazy = true,
		specs = {
			{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	-- {
	-- 	"echasnovski/mini.map",
	-- 	version = false,
	-- 	config = function()
	-- 		local MiniMap = require("mini.map")
	-- 		MiniMap.open()
	-- 		local gitsigns_integration = MiniMap.gen_integration.gitsigns({
	-- 			add = "GitSignsAdd",
	-- 			change = "GitSignsChange",
	-- 			delete = "GitSignsDelete",
	-- 		})
	-- 		MiniMap.setup({ integrations = { gitsigns_integration } })
	-- 		vim.keymap.set("n", "<leader>mc", MiniMap.close)
	-- 		vim.keymap.set("n", "<leader>mf", MiniMap.toggle_focus)
	-- 		vim.keymap.set("n", "<leader>mo", MiniMap.open)
	-- 	end,
	-- },
}
