return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			latex = { "vale" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })

		vim.keymap.set("n", "<leader>ld", function()
			local l = lint.linters_by_ft[vim.bo.filetype] or {}
			if next(l) == nil then
				return
			end
			local ns = lint.get_namespace(l[1])
			print(ns)
			vim.diagnostic.enable(not vim.diagnostic.is_enabled({ ns_id = ns, bufnr = 0 }), { ns_id = ns, bufnr = 0 })
		end, { desc = "Toggle linter for current buffer", noremap = true }) -- Toggle linter for current buffer

		vim.keymap.set("n", "<leader>ls", function()
			local l = lint.linters_by_ft[vim.bo.filetype] or {}
			if next(l) == nil then
				return
			end
			local ns = lint.get_namespace(l[1])
			vim.diagnostic.enable(not vim.diagnostic.is_enabled({ ns_id = ns }), { ns_id = ns })
		end, { desc = "Toggle linter", noremap = true }) -- Toggle linter
	end,
}
