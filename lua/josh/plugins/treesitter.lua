return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- Import the internal parser module
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		-- Local swift parser
		parser_config.swift = {
			install_info = {
				-- Use expand to ensure the path is absolute
				url = vim.fn.expand("~/.config/nvim/parsers/tree-sitter-swift"),
				files = { "src/parser.c", "src/scanner.c" },
				-- Skip the generation step (downloaded the files)
				requires_generate_from_grammar = false,
			},
			filetype = "swift",
		}

		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			-- List of parsers to ignore installing (or "all")
			ignore_install = { "swift" },

			modules = {},

			highlight = {
				enable = true,
				disable = { "latex" },
			},
			-- enable indentation
			indent = { enable = true },
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
				"cpp",
				"latex",
				-- TODO: Turn on verilog later, when it is working
				-- "verilog",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			-- ignore_install = { "latex" },
		})
	end,
}
