return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets", -- useful snippets
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
	},
	config = function()
		-- local luasnip = require("luasnip")
		-- luasnip.setup(opts)
		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		-- TODO: This is working right now but is kind of sketch, not sure why, priorities are not working right
		-- Need to figure out a good way to test the priority values
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { "~/.config/nvim/lua/josh/snippets", default_priority = 2000 },
		})
	end,
}
