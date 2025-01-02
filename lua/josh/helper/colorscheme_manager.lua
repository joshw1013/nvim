local M = {}

function M.load_last_colorscheme()
	local last_colorscheme_file = vim.fn.expand("~/.config/nvim/last_colorscheme.lua")

	local handle = vim.loop.fs_open(last_colorscheme_file, "r", 438) -- 438 is octal for 0666
	if not handle then
		vim.schedule(function()
			vim.cmd("colorscheme tokyonight")
		end)
		return
	end

	vim.loop.fs_fstat(handle, function(err1, stat)
		if err1 or not stat then
			vim.loop.fs_close(handle)
			vim.schedule(function()
				vim.cmd("colorscheme tokyonight")
			end)
			return
		end

		vim.loop.fs_read(handle, stat.size, 0, function(err2, data)
			vim.loop.fs_close(handle)
			if err2 or type(data) == "nil" then
				vim.schedule(function()
					vim.cmd("colorscheme tokyonight")
				end)
				return
			end
			local chunk, load_err = load(data)
			if not chunk then
				vim.schedule(function()
					print("Error loading last colorscheme: " .. load_err)
					vim.cmd("colorscheme tokyonight")
				end)
			else
				local success, exec_err
				vim.schedule(function()
					success, exec_err = pcall(chunk)
					if not success then
						print("Error executing last colorscheme: " .. exec_err)
						vim.cmd("colorscheme tokyonight")
					end
				end)
			end
		end)
	end)
end

-- Function to save the current colorscheme asynchronously
function M.save_colorscheme()
	vim.schedule_wrap(function()
		local colorscheme = vim.g.colors_name or "tokyonight"
		local data = 'vim.cmd("colorscheme ' .. colorscheme .. '")\n'
		local filename = vim.fn.expand("~/.config/nvim/last_colorscheme.lua")

		vim.loop.fs_open(filename, "w", 438, function(err1, fd)
			if err1 or not fd then
				return
			end

			vim.loop.fs_write(fd, data, 0, function(err2)
				if not err2 then
					vim.loop.fs_close(fd)
				end
			end)
		end)
	end)()
end

-- Auto-command to save the colorscheme whenever it changes
local timer = vim.loop.new_timer()
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Stop any existing timer
		timer:stop()

		-- Start a new timer for 5 seconds
		timer:start(5000, 0, function()
			-- Call save_colorscheme after 5 seconds in Neovim's main event loop
			-- If another ColorScheme is switched within 5 seconds timer will be reset
			vim.schedule(function()
				M.save_colorscheme()
			end)
		end)
	end,
})

return M
