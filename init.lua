--[[
Antonio Rocchia, Neovim configuration.
11/07/2023
--]]

-- Set leader key before plugins are required
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Reset default behaviour of <Space>
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

require 'editor_settings'

-- Install package manager
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,

  },

  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },

  -- Includes configurations for lsp, treesitter and autocompletition
  require 'plugins.basic-ide-fun',
  require 'plugins.ui',
  require 'plugins.nvim',
  require 'plugins.git',
}, {})


local mygroup = vim.api.nvim_create_augroup('tonino_au', { clear = true })
-- vim.api.nvim_create_autocmd(
--   {
--
--   }

vim.keymap.set('n', '<leader>d', vim.cmd.Ex, { desc = 'Go back to folderview' })
vim.keymap.set('n', '<leader>f', vim.cmd.Format, { desc = 'Format the document using the lsp server' })
