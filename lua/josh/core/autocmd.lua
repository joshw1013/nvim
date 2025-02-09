vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		-- Does not work if ro are not consecutive
		-- vim.opt_local.formatoptions:remove("ro")
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
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
	pattern = { "c", "cpp" }, -- Use filetypes instead of patterns here
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
