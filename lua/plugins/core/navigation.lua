local Helpers = require("helpers")

local Navigation = {}

--#region WhichKey
local WhichKey = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
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
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}

table.insert(Navigation, WhichKey)
--#endregion

--#region NeoTree
-- TODO: Disable Netrw
local NeoTree = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  cmd = "NeoTree",
  keys = {
    -- Press '?' to get mappings help inside NeoTree window
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer Neotree (cwd)"
    },
    { "<leader>E", "<leader>fE", desc = "Explorer cwd (Neotree)",      remap = true },
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = Helpers.get_root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
  },
  init = function()
    -- Start Neotree automatically if vim is launched on a directory
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(tostring(vim.fn.argv(0)))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    -- read lua require("neo-tree").paste_default_config()
    -- or https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
    filesystem = {
      bind_to_cwd = false,
      use_libuv_file_watcher = true,
      follow_current_file = { enabled = true },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
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

--#region Telescope
local Telescope = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  dependencies = {
    -- Make sure to install ripgrep and fd on your system
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { "folke/trouble.nvim" },
  },
  keys = {
    { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>/", Helpers.telescope("live_grep"),                     desc = "Grep (root dir)" },
    { "<leader>:", "<cmd>Telescope command_history<cr>",               desc = "Command History" },
    {
      "<leader><space>",
      Helpers.telescope("files"),
      desc = "Find Files (root dir)"
    },
    -- find
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                            desc = "Buffers" },
    {
      "<leader>ff",
      Helpers.telescope("files"),
      desc = "Find Files (root dir)"
    },
    { "<leader>fF", Helpers.telescope("files", { cwd = false }),             desc = "Find Files (cwd)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                           desc = "Recent" },
    { "<leader>fR", Helpers.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>",                        desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>",                         desc = "status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>",                          desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>",                       desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",          desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>",                    desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                           desc = "Commands" },
    {
      "<leader>sd",
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      desc = "Document diagnostics"
    },
    {
      "<leader>sD",
      "<cmd>Telescope diagnostics<cr>",
      desc = "Workspace diagnostics"
    },
    { "<leader>sg", Helpers.telescope("live_grep"),                  desc = "Grep (root dir)" },
    { "<leader>sG", Helpers.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                  desc = "Help Pages" },
    {
      "<leader>sH",
      "<cmd>Telescope highlights<cr>",
      desc = "Search Highlight Groups"
    },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                         desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                       desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>",                                           desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>",                                     desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>",                                          desc = "Resume" },
    { "<leader>sw", Helpers.telescope("grep_string", { word_match = "-w" }),              desc = "Word (root dir)" },
    { "<leader>sW", Helpers.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
    {
      "<leader>sw",
      Helpers.telescope("grep_string"),
      mode = "v",
      desc = "Selection (root dir)"
    },
    {
      "<leader>sW",
      Helpers.telescope("grep_string", { cwd = false }),
      mode = "v",
      desc = "Selection (cwd)"
    },
    {
      "<leader>uC",
      Helpers.telescope("colorscheme", { enable_preview = true }),
      desc = "Colorscheme with preview"
    },
    {
      "<leader>ss",
      Helpers.telescope("lsp_document_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      Helpers.telescope("lsp_dynamic_workspace_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol (Workspace)",
    },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      sorting_strategy = "descending",
      selection_strategy = "reset",
      scroll_strategy = "limit",
      layout_strategy = "horizontal",
      winblend = 0,
      wrap_results = false,
      initial_mode = "insert",
      mappings = {
        i = {
          -- Main key bindings
          ["<C-j>"] = function(...)
            return require("telescope.actions").move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            return require("telescope.actions").move_selection_previous(...)
          end,
          ["<C-q>"] = function(...)
            return require("telescope.actions").close(...)
          end,
          ["<C-h>"] = function(...)
            return require("telescope.actions").cycle_history_prev(...)
          end,
          ["<C-l>"] = function(...)
            return require("telescope.actions").cycle_history_next(...)
          end,
          ["<CR>"] = function(...)
            return require("telescope.actions").select_default(...)
          end,
          ["<C-f>"] = function(...)
            return require("telescope.actions").preview_scrolling_down(...)
          end,
          ["<C-b>"] = function(...)
            return require("telescope.actions").preview_scrolling_up(...)
          end,
          ["<C-i>"] = function (...)
            return require("telescope.actions").toggle_selection(...)
          end,
          ["<C-w>"] = function(...)
            return require("telescope.actions").which_key(...)
          end,
          -- Trouble.nvim integration
          ["<A-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<C-t>"] = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
          end,
        },
        n = {
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
          ["<C-j>"] = function(...)
            return require("telescope.actions").move_selection_next(...)
          end,
          ["<C-k>"] = function(...)
            return require("telescope.actions").move_selection_previous(...)
          end,
          -- Trouble.nvim integration
          ["<A-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<C-t>"] = function(...)
            return require("trouble.providers.telescope").open_selected_with_trouble(...)
          end,
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
  },
}

table.insert(Navigation, Telescope)
--#endregion

return Navigation
