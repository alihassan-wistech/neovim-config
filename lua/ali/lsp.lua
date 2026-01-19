-- 1. Define the Emmet configuration
local emmet_config = {
  cmd = { "emmet-ls", "--stdio" },
  filetypes = { 
    "html", "typescriptreact", "javascriptreact", 
    "css", "sass", "scss", "less", "blade", "php" 
  },
  root_dir = vim.fs.root(0, { ".git", "package.json" }),
  settings = {
    -- Any specific server settings go here
  },
}

-- 2. Register it with the new native system
vim.lsp.config("emmet_ls", emmet_config)

-- 3. Enable it
vim.lsp.enable("emmet_ls")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "blade",
  callback = function()
    vim.lsp.enable("emmet_ls")
  end,
})
