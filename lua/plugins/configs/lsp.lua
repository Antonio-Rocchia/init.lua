local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

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
