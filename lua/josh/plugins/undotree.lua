return {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local undotree = require("undotree")
		undotree.setup({
			vim.keymap.set(
				"n",
				"<leader>u",
				require("undotree").toggle,
				{ noremap = true, silent = true, desc = "Toggle undotree" }
			),
		})
	end,
	keys = { -- load the plugin only when using it's keybinding:
		{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
	},
}
