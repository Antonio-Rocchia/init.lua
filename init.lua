--[[
Antonio Rocchia, Neovim configuration.
11/07/2023
--]]
print("Buon divertimento")

-- Set leader key before plugins are required
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })


--------------- [[ Setting options ]] ---------------
-- See `:help vim.o`

-- Don't highlight every line that matches when searching in file, only one
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 8
vim.wo.signcolumn = 'yes'
vim.opt.colorcolumn = "80"

vim.wo.number = true
vim.wo.relativenumber = true
-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true

-- Better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- 0 = From netrw open file in the netrw window
-- 4 = From netrw open file in the last window you've been before netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 0

--------------- [[ Plugins ]] ---------------
require 'plugins'


--------------- [[ Key mappings ]] ---------------
require 'keymaps'
