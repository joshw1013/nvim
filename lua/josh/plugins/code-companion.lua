return {
	"olimorris/codecompanion.nvim",
	event = "BufEnter",
	opts = {
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_vars = true,
					make_slash_commands = true,
					show_result_in_chat = true,
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"ravitemer/mcphub.nvim",
	},
	keys = {
		{ "<leader>cc", "<cmd>CodeCompanionChat<CR>", desc = "Toggle file explorer" },
		{ mode = { "n", "x" }, "<leader>ci", "<cmd>CodeCompanion<CR>", desc = "Toggle file explorer" },
	},
}
