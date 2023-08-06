local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
  {
    spec = {
      { import = "tonino.plugins.core" },
      { import = "tonino.plugins.core.colorschemes" },
      { import = "tonino.plugins.core.navigation" },
      -- Enabled quality of life plugins
      { import = "tonino.plugins.core.conveniences.autotag" },
      { import = "tonino.plugins.core.conveniences.mini" },
      { import = "tonino.plugins.core.conveniences.which-key" },

      -- Extra functionalities
      { import = "tonino.plugins.extra.navigation" },
      -- Language specific imports
      { import = "tonino.plugins.extra.lang.java" },
    },
    performance = {
      rtp = {
        -- disable rtp plugins
        disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        -- "tarPlugin",
        "tohtml",
        "tutor",
        -- "zipPlugin",
        }
      }
    }
  }
)
