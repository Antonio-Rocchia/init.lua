local opts = {
  ensure_installed = { 'lua', 'javascript' },

  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<A-+>',
      node_incremental = '<A-+>',
      node_decremental = '<A-->',
      scope_incremental = '<A-s>',
    }
  }
}

return opts
