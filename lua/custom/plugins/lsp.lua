-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {},
  html = { filetypes = { 'html', 'twig', 'hbs'} },
  csharp_ls = {},
  cssls = {},
  eslint = {
    root_dir = require('lspconfig.util').root_pattern('.eslintrc.js', '.eslintrc')
  },
	prettier = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- setup lsps not found in mason
local other_lsp_setup = function (on_attach, capabilities)
  require('lspconfig').dartls.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })
end

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, _)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end)
  vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format { async = true } end)
  vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end)
end

return
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    config = function()
      -- mason-lspconfig requires that these setup functions are called in this order
      -- before setting up the servers.
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- Setup neovim lua configuration
      require('neodev').setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require 'mason-lspconfig'

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }

      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
            root_dir = (servers[server_name] or {}).root_dir,
          }
        end,
      }

      other_lsp_setup(on_attach, capabilities)
    end
  }
