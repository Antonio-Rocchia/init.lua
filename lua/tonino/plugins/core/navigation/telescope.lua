return {
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
      sorting_strategy = "ascending",
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
          ["<C-i>"] = function(...)
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
