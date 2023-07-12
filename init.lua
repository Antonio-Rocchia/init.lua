--[[
Antonio Rocchia, Neovim configuration.
11/07/2023
--]]

-- Set leader key before plugins are required
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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


--[[
-- PLUGINS
--]]
require('lazy').setup({

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  --[[
  -- Plugin configurations
  --]]

  -- Includes configurations for lsp, treesitter and autocompletition
  require 'plugins.basic-ide-fun',

  require 'plugins.ui',
  require 'plugins.nvim',
}, {})

--[[
-- Editor settings
--]]
require 'editor_settings'
vim.keymap.set('n', '<leader>d', ':Rex<enter>', { desc = 'Go back to folderview' })
vim.keymap.set('n', '<leader>f', ':Format<enter>', { desc = 'Format the document using the lsp server' })
