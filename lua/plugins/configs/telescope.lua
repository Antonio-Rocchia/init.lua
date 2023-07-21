local M = {}

function M.get_dependencies()
  local dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

    }

  return dependencies
end

function M.get_opts()
  local opts = {
    defaults = {
      sorting_strategy = "descending",
      selection_strategy = "reset",
      scroll_strategy = "limit",
      layout_strategy = "horizontal",
      winblend = 0,
      wrap_results = false,
      initial_mode = "insert",
      path_display = { "smart" },
      mappings = {
        i = {
          ["<C-k>"] = "move_selection_next",
          ["<C-j>"] = "move_selection_previous",
          ["<C-q>"] = "close",
          ["<C-h>"] = "cycle_history_next",
          ["<C-l>"] = "cycle_history_prev",
          ["<CR>"] = "select_default",
          ["<C-w>"] = "which_key",
        },
        n = {
          ["<C-k>"] = "move_selection_next",
          ["<C-j>"] = "move_selection_previous",
          ["<C-w>"] = "which_key",
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
      },
      set_env = { ["COLORTERM"] = "truecolor" },
      file_ignore_patterns = {},
    },
    pickers = {
    },
    extensions = {
      fzf = {
        -- To get fzf loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        -- require('telescope').load_extension('fzf')
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      }
    },
  }

  return opts
end

function M.run_config(opts)
  pcall(require('telescope').load_extension, 'fzf')
end

return M
