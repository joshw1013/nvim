return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter")

		-- Optional don't need to call this
		treesitter.setup()

		treesitter.install({
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
		})

		require("nvim-ts-autotag").setup()

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "*" },
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft)

				if ft == "latex" then
					return
				end

				if not vim.treesitter.language.add(lang) then
					-- this stupid tracking is here only because
					-- they have added warnings on absent parsers
					local available = vim.g.ts_available or require("nvim-treesitter").get_available()
					if not vim.g.ts_available then
						vim.g.ts_available = available
					end
					if vim.tbl_contains(available, lang) then
						require("nvim-treesitter").install(lang)
					end
				end

				if vim.treesitter.language.add(lang) then
					vim.treesitter.start(args.buf, lang)
					-- this is an experimental feature
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
				end
			end,
		})
		-- Incremental selection
		-- vim.keymap.set("n", "<C-space>", "van", { remap = true, desc = "Init Treesitter Selection" })
		-- vim.keymap.set("x", "<C-space>", "an", { remap = true, desc = "Increment Treesitter Selection" })
		-- vim.keymap.set("x", "<bs>", "in", { remap = true, desc = "Decrement Treesitter Selection" })
	end,
}
