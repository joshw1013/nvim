return {
	"ahmedkhalf/project.nvim",
	dependecies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local project = require("project_nvim")
		project.setup({
			-- Show hidden files in telescope
			show_hidden = false,

			-- What scope to change the directory, valid options are
			-- * global (default)
			-- * tab
			-- * win
			scope_chdir = "global",

			-- Path where project.nvim will store the project history for use in
			-- telescope
			datapath = vim.fn.stdpath("data"),
		})

		require("telescope").load_extension("projects")
	end,
}
