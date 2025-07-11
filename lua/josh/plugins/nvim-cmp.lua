return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local lspkind = require("lspkind")

		-- load snippets from path/of/your/nvim/config/my-cool-snippets
		-- TODO: Figure out how to add priority for elements from this extension
		-- require("luasnip.loaders.from_vscode").lazy_load({
		-- 	paths = { "~/.config/nvim/lua/josh/snippets", default_priority = 2000 },
		-- })
		--
		-- -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		-- require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview, noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- Don't need the commented out stuff right now
				-- due to cmp entries
				--
				-- LuaSnip commands to jump to next node
				-- vim.keymap.set({ "i" }, "<C-K>", function()
				-- luasnip.expand()
				-- end, { silent = true }),
				vim.keymap.set({ "i", "s" }, "<C-L>", function()
					luasnip.jump(1)
				end, { silent = true }),
				vim.keymap.set({ "i", "s" }, "<C-H>", function()
					luasnip.jump(-1)
				end, { silent = true }),

				-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
				-- 	if luasnip.choice_active() then
				-- 		luasnip.change_choice(1)
				-- 	end
				-- end, { silent = true }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip", priority = 10 }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
				{ name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
