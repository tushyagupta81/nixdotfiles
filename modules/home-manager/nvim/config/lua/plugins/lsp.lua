return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"luckasRanarison/tailwind-tools.nvim",
		"onsails/lspkind-nvim",
	},
	event = "VeryLazy",
	config = function()
		-- 1. find venv folder in current dir or 1 level deeper (venv/ or proj/venv)
		local function find_venv(start_path) -- Finds the venv folder required for LSP
			-- Check current directory (if venv folder is at root)
			local venv_path = start_path .. "/venv"
			if vim.fn.isdirectory(venv_path) == 1 then
				return venv_path
			end
			-- Check one level deeper (e.g if venv is in proj/venv)
			local handle = vim.loop.fs_scandir(start_path)
			if handle then
				while true do
					local name, type = vim.loop.fs_scandir_next(handle)
					if not name then
						break
					end
					if type == "directory" then
						venv_path = start_path .. "/" .. name .. "/venv"
						if vim.fn.isdirectory(venv_path) == 1 then
							return venv_path
						end
					end
				end
			end

			return nil
		end

		local lspconfig = require("lspconfig")

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		-- 2. If the venv is found during init, reload LSP with venv vars set
		local pyright_restarted = false

		lspconfig.pyright.setup({
			capabilities = capabilities,
			---@diagnostic disable-next-line: unused-local
			on_init = function(client)
				if not pyright_restarted then -- Only proceed if we haven't restarted yet
					local cwd = vim.fn.getcwd()
					local venv_path = find_venv(cwd)
					if venv_path then
						print("Venv folder found: " .. venv_path)
						vim.env.VIRTUAL_ENV = venv_path
						vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH

						-- Set the flag to true
						pyright_restarted = true

						vim.schedule(function()
							vim.cmd("LspRestart pyright")
							print("Pyright restarted with new venv settings")
						end)
					else
						print("No venv folder found in or one level below current directory: " .. cwd)
					end
				end
				return true
			end,
		})

		require("fidget").setup({})
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"ts_ls",
				"emmet_language_server",
				"eslint",
				"pyright",
				"emmet_ls",
				"tailwindcss",
				-- "ast_grep",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
				["emmet_language_server"] = function()
					lspconfig.emmet_language_server.setup({
						filetypes = {
							"css",
							"eruby",
							"html",
							"javascript",
							"javascriptreact",
							"less",
							"sass",
							"scss",
							"pug",
							"typescriptreact",
						},
					})
				end,
			},
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"ruff", -- python linter
				"flake8", -- python linter
				"eslint_d",
				"clang-format",
				-- "rustfmt",
			},
		})
		require("luasnip.loaders.from_vscode").lazy_load()
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			-- Auto selects first item in completion list
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "codeium" },
				{ name = "copilot" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				-- format = require("tailwindcss-colorizer-cmp").formatter,
				format = require("lspkind").cmp_format({
					before = require("tailwind-tools.cmp").lspkind_format,
				}),
			},
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
		vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
	end,
}
