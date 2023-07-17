return {
  {
    --[[ Configure Treesitter ]]
    --Highlight, edit, and navigate code
    -- See `:help nvim-treesitter`
    'nvim-treesitter/nvim-treesitter',

    dependencies = {
      --'nvim-treesitter/nvim-treesitter-textobjects',
    },

    build = ':TSUpdate',

    config = function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 'lua', 'javascript' },

        -- Auto install languages that are not installed
        auto_install = false,

        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- cmp addons
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- [[ Configure nvim-cmp ]]
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
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
          --Trigger completion when it's not working automatically
          ['<C-Space>'] = cmp.mapping.complete {},
          --writes the selected cmp suggestion
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          --When in insert mode: If cmp is visible -> go to next suggestion, If in a snippet -> go to next writable part of the snippet
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          --Same as previous but go back instaed
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
          { name = 'path' },
        },
      }
    end,
  },
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',

    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- docs and completion for the nvim lua API.
      'folke/neodev.nvim',

    },

    config = function()
      local servers = {

        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      require('neodev').setup()

      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        -- Here you can set all keybindings and function that will activate
        -- when an lsp server attaches on the buffer.
        -- Make sure to bind keys and function to the buffer for the best experience

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' }
        )
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          }
        end,
      }

      -- Diagnostic informations
      --vim.keymap.set('n', '<leader>djp', vim.diagnostic.goto_prev, { desc = 'Jump to the previous diagnostic message' })
      --vim.keymap.set('n', '', vim.diagnostic.goto_next, { desc = 'Jump to the next diagnostic message' })
      --vim.keymap.set('n', '', vim.diagnostic.open_float, { desc = 'Expands floating diagnostic message' })
      --vim.keymap.set('n', '', vim.diagnostic.setloclist, { desc = 'Open the issues list with diagnostic' })
    end,
  }
}
