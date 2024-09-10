return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "flake8", "ruff" },
			-- rust = { "bacon" },
			-- lua = { "luacheck" },
		}

		lint.linters.eslint_d = {
			-- From nvim-lint README
			cmd = function()
				local local_binary = vim.fn.fnamemodify("./node_modules/.bin/" .. "eslint_d", ":p")
				return vim.loop.fs_stat(local_binary) and local_binary or "eslint_d"
			end,
			-- ^ this was directly copied from nvim-lint README

			args = {
				"--no-warn-ignored", -- <-- this is the key argument
				"--format",
				"json",
				"--stdin",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			},
		}

		local pattern = "[^:]+:(%d+):(%d+):(%w+):(.+)"
		local groups = { "lnum", "col", "code", "message" }
		lint.linters.flake8 = {
			cmd = "flake8",
			stdin = true,
			args = {
				"--no-warn-ignored", -- <-- this is the key argument
				"--format=%(path)s:%(row)d:%(col)d:%(code)s:%(text)s",
				"--no-show-source",
				"--stdin-display-name",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
				"-",
			},
			ignore_exitcode = true,
			parser = require("lint.parser").from_pattern(pattern, groups, nil, {
				["source"] = "flake8",
				["severity"] = vim.diagnostic.severity.WARN,
			}),
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>gl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
