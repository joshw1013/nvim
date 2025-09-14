return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- NOTE: Set this for debuging
		vim.lsp.set_log_level("debug")

		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				vim.diagnostic.config({ jump = { float = true } }) -- Add floating window when jumping dianostics

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local function get_matlab_install_path()
			local home = os.getenv("HOME") or ""
			local possible_paths = {
				"/Applications/MATLAB_R2022a.app",
				"/mnt/c/Program Files/MATLAB/R2022b",
				-- home,
			}

			for _, path in ipairs(possible_paths) do
				if vim.fn.isdirectory(path) == 1 then
					return path
				end
			end

			-- print("MATLAB installation not found in predefined paths.")
			return nil
		end
		get_matlab_install_path()

		-- Enable Dafny as that is not installed through Mason
		vim.lsp.enable("dafny")

		-- Set the capabilites to all LSP (vim.lsp.config does deep merging)
		-- lspconfig takes precedence over global config / capabilities
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Custom settings for specific LSP. These take the highest precedence
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		vim.lsp.config("matlab_ls", {
			filetypes = { "matlab" },
			root_dir = function(fname, on_dir)
				-- local filepath = vim.api.nvim_buf_get_name(0)
				local directory = vim.fn.fnamemodify(fname, ":h")
				on_dir(directory)
			end,
			settings = {
				matlab = {
					indexWorkspace = true,
					installPath = get_matlab_install_path(),
					matlabConnectionTiming = "onStart",
					telemetry = false,
				},
			},
			single_file_support = true,
		})

		vim.lsp.config("verible", {
			root_dir = function(_, on_dir)
				on_dir(vim.loop.cwd())
			end,
		})
	end,
}
