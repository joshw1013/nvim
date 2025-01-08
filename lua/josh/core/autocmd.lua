vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function()
		vim.opt_local.formatoptions:remove("ro")
	end,
})

-- Associate .v files with Verilog filetype
vim.filetype.add({
	extension = {
		v = "verilog", -- Treat .v files as Verilog files
	},
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.html",
	callback = function()
		vim.bo.filetype = "html"
	end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.v",
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "latex", "tex" },
	callback = function()
		print("test")
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end,
})
