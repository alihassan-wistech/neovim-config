-- Ensure .blade.php files use the blade filetype
vim.filetype.add({
  pattern = {
    ['.*%.blade%.php'] = 'blade',
  },
})

-- Force the blade filetype to use the blade parser
vim.api.nvim_create_autocmd("FileType", {
  pattern = "blade",
  callback = function()
    vim.treesitter.start()
  end,
})
