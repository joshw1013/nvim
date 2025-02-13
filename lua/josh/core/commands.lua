-- List what buffers are modified
-- Define the Lua function directly
function _G.ls_modified()
	local buffers = vim.fn.getbufinfo({ bufmodified = 1 })
	for _, buf in ipairs(buffers) do
		local bufnr = buf.bufnr
		local fname = vim.fn.bufname(bufnr)
		if not fname:match("NvimTree") then
			local line = buf.lnum
			print(
				string.format(
					"%d %s %s line %d",
					bufnr,
					vim.fn.getbufvar(bufnr, "&modified") == 1 and "%a" or "",
					fname,
					line
				)
			)
		end
	end
end

-- Create the Vim command to call the Lua function
vim.cmd("command! LsModified lua _G.ls_modified()")

vim.api.nvim_create_user_command("FormatDisable", function(args)
	if args.bang then
		-- FormatDisable! will disable formatting just for this buffer
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})
