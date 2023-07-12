-- [[ Setting options ]]
-- See `:help vim.o`
print("Have fun coding :D")
-- Don't highlight every line that matches when searching in file, only one
vim.o.hlsearch = false
-- Highlight incrementaly while you type the pattern
vim.o.incsearch = true
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 8
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
-- Colors the columns to make a ruler
vim.opt.colorcolumn = "80"

-- Precede each line with its line number
vim.wo.number = true
vim.wo.relativenumber = true
-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- 0 = From netrw open file in the netrw window
-- 4 = From netrw open file in the last window you've been before netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3
