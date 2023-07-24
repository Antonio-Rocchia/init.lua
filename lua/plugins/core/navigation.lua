local Navigation = {}

--#region WhichKey
local WhichKey = {}

WhichKey.opts = {
  plugins = { spelling = true },
  defaults = {
    mode = { "n", "v" },
    ["g"] = { name = "+goto" },
    ["gz"] = { name = "+surround" },
    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },
    ["<leader><tab>"] = { name = "+tabs" },
    ["<leader>b"] = { name = "+buffer" },
    ["<leader>c"] = { name = "+code" },
    ["<leader>f"] = { name = "+file/find" },
    ["<leader>g"] = { name = "+git" },
    ["<leader>gh"] = { name = "+hunks" },
    ["<leader>q"] = { name = "+quit/session" },
    ["<leader>s"] = { name = "+search" },
    ["<leader>u"] = { name = "+ui" },
    ["<leader>w"] = { name = "+windows" },
    ["<leader>x"] = { name = "+diagnostics/quickfix" },
  },
}

function WhichKey.setup(opts)
  local wk = require("which-key")
  wk.setup(opts)
  wk.register(opts.defaults)
end

WhichKey.spec = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = WhichKey.opts,
  config = function(_, opts)
    WhichKey.setup(opts)
  end,
}

table.insert(Navigation, WhichKey.spec)
--#endregion

--#region NeoTree
local NeoTree = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "NeoTree",
  Keys = {
    -- Press '?' to get mappings help inside NeoTree window
  },
  opts = {
    -- read lua require("neo-tree").paste_default_config() 
    -- or https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    filesystem = {
      bind_to_cwd = false,
      hijack_netrw_behavior = "open_default",
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  }
}

table.insert(Navigation, NeoTree)
--#endregion

return Navigation
