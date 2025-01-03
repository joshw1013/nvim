-- Setup for lualine
require("josh.plugins.linting")
local D = {}
function D.has_update()
	-- Diagnostic is on for current buffer
	return vim.diagnostic.is_enabled({ bufnr = 0 })
end
function D.update()
	return " "
end

-- Get this working with Linter
local function has_lint()
	local lint = require("lint")
	if not lint then
		return false
	end
	local l = lint.linters_by_ft[vim.bo.filetype] or {}
	if next(l) == nil then
		return false
	end
	local ns = lint.get_namespace(l[1])
	-- Lintinng is enabled for current buffer
	return vim.diagnostic.is_enabled({ ns_id = ns, bufnr = 0 })
end

function D.color()
	-- has_lint should cover all cases but just in case
	if not has_lint() and not D.has_update() then
		return { fg = "#de3163" } -- Cerise red
	elseif not has_lint() and D.has_update() then
		return { fg = "#ffff8f" } -- Bright yellow
	else
		return { fg = "#39ff14" } -- Neon green
	end
end

return D

-- 	lazy_status.updates,
-- 	cond = lazy_status.has_updates,
-- 	color = { fg = "#ff9e64" },
-- },
