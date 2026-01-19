---@diagnostic disable-next-line: undefined-global
local vim = vim

-- Configure how diagnostics (errors/warnings) are displayed
vim.diagnostic.config({
  -- 1. Inline/Virtual Text: Display the error at the end of the line
  virtual_text = {
    spacing = 4,
    prefix = "●", -- You can use icons like "", "", "󰅚"
  },
  -- 2. Show signs in the gutter (sidebar)
  signs = true,
  -- 3. Update errors as you type (set to false for better performance)
  update_in_insert = false,
  -- 4. Sort by severity (show Errors before Warnings)
  severity_sort = true,

  -- 5. Floating window settings (the popup on hover)
  float = {
    border = "rounded",
    source = "always", -- Shows if the error is from PHP, Tailwind, etc.
    header = "",
    prefix = "",
  },
})

-- Change the gutter icons to look like VS Code
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  -- vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
