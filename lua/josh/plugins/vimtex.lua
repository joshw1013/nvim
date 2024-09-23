return {
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			vim.cmd("filetype plugin indent on")
			vim.cmd("syntax enable")
			vim.g.vimtex_view_method = "sioyek"
			vim.g.vimtex_compiler_method = "latexmk"
			-- vim.g.maplocalleader = ","
			-- VimTeX configuration goes here
			-- Added from Ethan Lu blog on Sioyek with VimTex
			vim.g.vimtex_callback_progpath = "wsl nvim"
			-- vim.g.vimtex_view_sioyek_exe = "/mnt/c/Users/joshu/sioyek-release-windows/sioyek.exe"
		end,
	},
}
