return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")

    substitute.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "gs", substitute.operator, { desc = "Substitute with motion" })
    keymap.set("n", "gss", substitute.line, { desc = "Substitute line" })
    keymap.set("n", "gS", substitute.eol, { desc = "Substitute to end of line" })
    keymap.set("x", "gs", substitute.visual, { desc = "Substitute in visual mode" })
  end,
}
