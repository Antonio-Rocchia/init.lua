local QoL = {}

--#region MiniPairs
local MiniPairs = {
  "echasnovski/mini.pairs",
  event = "VeryLazy",
  opts = {},
}

table.insert(QoL, MiniPairs)
--#endregion

--#region MiniSurround
local MiniSurround = {
  "echasnovski/mini.surround",
  opts = {
    mappings = {
      add = "gza", -- Add surrounding in Normal and Visual modes
      delete = "gzd", -- Delete surrounding
      find = "gzf", -- Find surrounding (to the right)
      find_left = "gzF", -- Find surrounding (to the left)
      highlight = "gzh", -- Highlight surrounding
      replace = "gzr", -- Replace surrounding
      update_n_lines = "gzn", -- Update `n_lines`
    },
  },
}

table.insert(QoL, MiniSurround)
--#endregion
return QoL
