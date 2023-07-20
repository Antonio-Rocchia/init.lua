--[[
Antonio Rocchia, key mappings for my neovim configuration

A lot of key mapping are set near the plugin for which they are set for
--]]
vim.keymap.set({ 'i', 'n' }, '<A-k>', '<Cmd>m -2<Enter>', { desc = 'Move the current line up by one' })
vim.keymap.set({ 'i', 'n' }, '<A-j>', '<Cmd>m +1<Enter>', { desc = 'Move the current line down by one' })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = 'Move a selection up by one' })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = 'Move a selection down by one' })
vim.keymap.set({ 'i', 'n' }, '<A-l>', '<Cmd> > <Enter>', { desc = 'Indent line to the right by shiftwidth' })
vim.keymap.set({ 'i', 'n' }, '<A-h>', '<Cmd> < <Enter>', { desc = 'Indent line to the left by shiftwidth' })
vim.keymap.set("v", "<A-h>", "<gv", { desc = 'Indent a selection to the right by shiftwidth' })
vim.keymap.set("v", "<A-l>", ">gv", { desc = 'Indent a selection to the left by shiftwidth' })

vim.keymap.set({ 'i', 'n' }, '<C-k>', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
  { desc = 'Add x lines before current, default = 1' })
vim.keymap.set({ 'i', 'n' }, '<C-j>', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
  { desc = 'Add x lines after current, default = 1' })

local wk = require("which-key")

wk.register({
  c = {
    name = 'code action',
    d = 'diagnostic'
  }
}, { prefix = '<leader>' })

vim.keymap.set('n', '<leader>cdp', vim.diagnostic.goto_prev, { desc = 'Jump to the previous diagnostic message' })
vim.keymap.set('n', '<leader>cdn', vim.diagnostic.goto_next, { desc = 'Jump to the next diagnostic message' })
vim.keymap.set('n', '<leader>cdf', vim.diagnostic.open_float, { desc = 'Expands floating diagnostic message' })
vim.keymap.set('n', '<leader>cdl', vim.diagnostic.setloclist, { desc = 'Open the issues list with diagnostic' })

vim.keymap.set('n', '<leader>e', vim.cmd.Lexplore, { desc = 'Go back to folderview' })
vim.keymap.set('n', '<leader>cf', vim.cmd.Format, { desc = 'Format the document using the lsp server' })

local telescope_builtin = require 'telescope.builtin'


vim.keymap.set('n', '<leader>tg', telescope_builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>tf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>th', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>tw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>tr', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>td', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
