local Code = {}

--#region Completition
local Completition = {
  'hrsh7th/nvim-cmp',
  version = false,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      opts = {
        history = true,
        delete_check_events = "TextChanged",
      },
    },
  },
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = "buffer" },
        { name = "path" },
      },
      experimental = {
        ghost_text = {
          hl_group = "CmpGhostText",
        },
      },
    }
  end,
}

table.insert(Code, Completition)
--#endregion

--#region Lsp
local Lsp = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
      build = ":MasonUpdate",
      opts = {
        ensure_installed = {},
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {},
        automatic_installation = false,
      },
    },
    { "folke/neodev.nvim",    opts = {} },
    { "hrsh7th/cmp-nvim-lsp", dependencies = { { "hrsh7th/nvim-cmp" } } },
    {
      "j-hui/fidget.nvim",
      tag = "legacy",
      event = "LspAttach",
      opts = {}
    },
  },
  keys = {
    -- read :h vim.diagnostic
    { "<leader>cd", vim.diagnostic.open_float, desc = "Line diagnostic" },
    { "[d",         vim.diagnostic.goto_prev,  desc = "Previous diagnostic" },
    { "]d",         vim.diagnostic.goto_next,  desc = "Next diagnostic" },
  },
  opts = {
    servers = {
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    },
  },
  config = function(_, opts)
    -- This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- to check nvim function that support lsp capabilities reaad :h vim.lsp
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action", buffer = bufnr })
      vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP: Format", buffer = bufnr })
      vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: Rename symbol", buffer = bufnr })
      vim.keymap.set("n", "<leader>cI", "<Cmd>LspInfo<CR>", { desc = "LSP: LspInfo", buffer = bufnr })
      vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help,
        { desc = "LSP: Signature documentation (temporary)", buffer = bufnr })
      vim.keymap.set("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder,
        { desc = "LSP: Add folder to workspace", buffer = bufnr })
      vim.keymap.set("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder,
        { desc = "LSP: Remove folder to workspace", buffer = bufnr })
      vim.keymap.set('n', '<leader>cwl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        { desc = "LSP: List workspace folders", buffer = bufnr })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: Goto declaration", buffer = bufnr })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: Goto definition", buffer = bufnr })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP: Goto implementation", buffer = bufnr })
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP: Goto type definition", buffer = bufnr })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover documentation", buffer = bufnr })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(opts.servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = opts.servers[server_name],
        }
      end,
    }
  end
}

table.insert(Code, Lsp)
--#endregion

--#region Treesitter
local Treesitter = {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {},
  opts = {
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
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

table.insert(Code, Treesitter)
--#endregion

return Code
