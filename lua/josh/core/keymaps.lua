vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
keymap.set("n", "<leader><", "10<C-w><", { desc = "Decrease window width" })
keymap.set("n", "<leader>>", "10<C-w>>", { desc = "Increase window width" })

keymap.set("n", "<leader>lf", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = "Toggle Diagnostics for current buffer", noremap = true }) -- Toggle diagnostics for current buffer

keymap.set("n", "<leader>la", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle Diagnostics for all buffers", noremap = true }) -- Toggle diagnostics for all buffers

local bind = vim.keymap.set
bind("n", "<leader>rr", "<cmd>source $HOME/.config/nvim/init.lua <CR>", { desc = "Reload config" })

-- Configure the unnamedplus register (system clipboard)
keymap.set({ "n", "v", "x", "s" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" }) --  move current buffer to new tab
keymap.set({ "n", "v", "x", "s" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" }) --  move current buffer to new tab

keymap.set("n", "<leader>nw", "<cmd>noa w<CR>", { desc = "Save without formatter" }) --  Don't run autocmds when saving
keymap.set("n", "<leader>me", "<cmd>FormatEnable<CR>", { desc = "Enable Automatic Formatting" }) --  Don't run autocmds when saving
keymap.set("n", "<leader>md", "<cmd>FormatDisable<CR>", { desc = "Disable Automatic Formatting" }) --  Don't run autocmds when saving
-- TODO: Figure out what to do with this
-- keymap.set("n", "<leader>cc", "<cmd>TSContextToggle<CR>", { desc = "Toggle TS Context" }) --  Toggle treesitter context
