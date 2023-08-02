local tonino_group = vim.api.nvim_create_augroup("tonino", { clear = true })

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = tonino_group,
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = tonino_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})
