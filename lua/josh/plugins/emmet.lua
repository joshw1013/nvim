return {
	"mattn/emmet-vim",
	ft = { "html", "css" },
	init = function()
		vim.g.user_emmet_install_global = 0
	end,

	config = function()
		-- Create an auto command to set up Emmet for HTML and CSS file types
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "html", "css" },
			command = "EmmetInstall",
		})
	end,
}
