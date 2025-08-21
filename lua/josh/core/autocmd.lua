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
	pattern = { "c", "cpp", "dafny" }, -- Use filetypes instead of patterns here
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "latex", "tex" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
	end,
})

local function substring_of_cwd(directory)
	require("josh.plugins")
	local Path = require("plenary.path")
	-- Create a Path object for the given directory
	-- Just creates a path object, does not create anything else
	local given_path = Path:new(directory)
	-- Get the current working directory
	local cwd_path = Path:new(vim.loop.cwd())

	-- Normalize and compare the paths

	-- print(cwd_path:expand())
	cwd_path = cwd_path:expand()
	given_path = given_path:expand()
	return cwd_path:find(given_path, 1, true) == 1
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	pattern = "*",
	callback = function()
		require("josh.plugins.formatting")
		-- Add directories here
		local dirs = {
			"~/Documents/VSCode/EECS482/p2-thread-library",
			"~/class/eecs482/p2",
			"~/Documents/VSCode/EECS482/p3-memory-management",
			"~/class/eecs482/p3",
			"~/Documents/VSCode/EECS482/p4-network-file-server",
			"~/class/eecs482/p4",
		}

		local match = false
		for _, dir in ipairs(dirs) do
			if substring_of_cwd(dir) then
				match = true
			end
		end
		if match then
			vim.opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
			vim.opt.shiftwidth = 4 -- 4 spaces for indent width
			-- print("FormatDisable")
			vim.cmd("FormatDisable")
		else
			local filetype = vim.bo.filetype
			if filetype ~= "python" then -- We want tab size of 4 for python
				vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
				vim.opt.shiftwidth = 2 -- 2 spaces for indent width
			end
			-- print("FormatEnable")
			vim.cmd("FormatEnable")
		end
	end,
})

-- Create an autocommand group to ensure the command is not duplicated
vim.api.nvim_create_augroup("DafnyIndentSettings", { clear = true })

-- When a Dafny file is opened, apply C-style indenting
vim.api.nvim_create_autocmd("FileType", {
	group = "DafnyIndentSettings",
	pattern = "dafny",
	command = "setlocal cindent",
})

local group = vim.api.nvim_create_augroup("SmartFolding", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = group,
	pattern = "*",
	callback = function(args)
		-- Use a protected call to safely check for the parser
		-- get_parser() returns nil if no parser is found
		local success, parser = pcall(vim.treesitter.get_parser, args.buf)
		local has_parser = success and parser

		if has_parser then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
		else
			vim.wo.foldmethod = "indent"
		end
	end,
})
