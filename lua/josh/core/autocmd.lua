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

local function is_same_as_cwd(directory)
	require("josh.plugins")
	local Path = require("plenary.path")
	-- Create a Path object for the given directory
	-- Just creates a path object, does not create anything else
	local given_path = Path:new(directory)
	-- Get the current working directory
	local cwd_path = Path:new(vim.loop.cwd())

	-- Normalize and compare the paths

	-- print(cwd_path:expand())
	return given_path:expand() == cwd_path:expand()
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	pattern = "*",
	callback = function()
		require("josh.plugins.formatting")
		-- Add directories here
		local dirs = { "~/Documents/VSCode/EECS482/p2-thread-library", "~/class/eecs482/p2" }

		local match = false
		for _, dir in ipairs(dirs) do
			if is_same_as_cwd(dir) then
				match = true
			end
		end
		if match then
			vim.opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
			vim.opt.shiftwidth = 4 -- 4 spaces for indent width
			-- print("FormatDisable")
			vim.cmd("FormatDisable")
		else
			vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
			vim.opt.shiftwidth = 2 -- 2 spaces for indent width
			-- print("FormatEnable")
			vim.cmd("FormatEnable")
		end
	end,
})
