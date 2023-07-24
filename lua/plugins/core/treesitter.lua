local Plugin = {}

Plugin.dependencies = {}

Plugin.keys = {}

Plugin.opts = {
  -- see :h nvim-treesitter-modules
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-Space>",
      node_incremental = "<C-Space>",
      node_decremental = "<bs>",
      scope_incremental = false,
    },
  },
  indent = { enable = true },
  -- Parser settings
  ensure_installed = {
    "lua",
    "html",
    "css",
    "javascript",
    "python",
    "bash",
  },
  auto_install = true,
}

function Plugin.setup(opts)
  require("nvim-treesitter.configs").setup(opts)
end

Plugin.spec = {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = Plugin.dependencies,
  keys = Plugin.keys,
  opts = Plugin.opts,
  config = function(_, opts)
    Plugin.setup(opts)
  end,
}

return Plugin.spec
