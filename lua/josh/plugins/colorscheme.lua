return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local transparent = false -- set to true if you would like to enable transparency

		local bg = "#011628"
		local bg_dark = "#011423"
		local bg_highlight = "#143652"
		local bg_search = "#0A64AC"
		local bg_visual = "#275378"
		local fg = "#CBE0F0"
		local fg_dark = "#B4D0E9"
		local fg_gutter = "#627E97"
		local border = "#547998"

		require("tokyonight").setup({
			style = "night",
			transparent = transparent,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				sidebars = transparent and "transparent" or "dark",
				floats = transparent and "transparent" or "dark",
			},
			on_colors = function(colors)
				colors.bg = bg
				colors.bg_dark = transparent and colors.none or bg_dark
				colors.bg_float = transparent and colors.none or bg_dark
				colors.bg_highlight = bg_highlight
				colors.bg_popup = bg_dark
				colors.bg_search = bg_search
				colors.bg_sidebar = transparent and colors.none or bg_dark
				colors.bg_statusline = transparent and colors.none or bg_dark
				colors.bg_visual = bg_visual
				colors.border = border
				colors.fg = fg
				colors.fg_dark = fg_dark
				colors.fg_float = fg
				colors.fg_gutter = fg_gutter
				colors.fg_sidebar = fg_dark
			end,
		})

		-- vim.cmd("colorscheme tokyonight")

		-- Function to load the last used colorscheme with error handling
		local function load_last_colorscheme()
			local last_colorscheme_file = vim.fn.expand("~/.config/nvim/last_colorscheme.lua")
			if vim.fn.filereadable(last_colorscheme_file) == 1 then
				local success, err = pcall(dofile, last_colorscheme_file)
				if not success then
					print("test")
					print("Error loading last colorscheme: " .. err)
					vim.cmd("colorscheme tokyonight")
				end
			else
				vim.cmd("colorscheme tokyonight")
			end
		end
		-- Function to save the current colorscheme
		local function save_colorscheme()
			local colorscheme = vim.g.colors_name
			local file = io.open(vim.fn.expand("~/.config/nvim/last_colorscheme.lua"), "w")
			if file then
				print("runs")
				if colorscheme then
					file:write('vim.cmd("colorscheme ' .. colorscheme .. '")\n')
				else
					file:write('vim.cmd("colorscheme tokyonight")\n')
				end
				file:close()
			end
		end

		-- Load the last used colorscheme on startup
		load_last_colorscheme()

		-- Auto-command to save the colorscheme whenever it changes
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				save_colorscheme()
			end,
		})
	end,
}
