return {
	"chipsenkbeil/distant.nvim",
	branch = "v0.3",
	config = function()
		require("distant"):setup({
			manager = { log_file = vim.fn.expand("~/.local/share/distant/distant.log"), log_level = "trace" },
		})
	end,
}
