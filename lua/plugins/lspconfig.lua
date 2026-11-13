-- LSP: servers are installed by Mason and enabled via vim.lsp.config / mason-lspconfig

-- Configures LuaLS for editing your Neovim config
require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = 'luvit-meta/library', words = { 'vim%.uv' } },
  },
}

-- Useful status updates for LSP
require('fidget').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    local goto_def_vsplit = function()
      require('telescope.builtin').lsp_definitions { jump_type = 'vsplit' }
      for key, value in pairs(vim.api.nvim_list_wins()) do
        print(key)
        print(value)
      end
      print(vim.inspect(vim.api.nvim_list_wins()))
      require('telescope.builtin').lsp_definitions {}
    end

    map('gv', goto_def_vsplit, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Highlight references of the word under the cursor when it rests there
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Broadcast nvim-cmp's extra completion capabilities to every server
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local servers = {
  clangd = {
    cmd = {
      'clangd',
      '--clang-tidy',
    },
  },
  gopls = {
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  sqlfluff = {},
  shellcheck = {
    filetypes = { 'sh', 'bash', 'zsh' },
  },
  starpls = {
    filetypes = { 'bzl', 'WORKSPACE', 'bazel' },
  },
  basedpyright = {},
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = true,
        check = {
          allFeatures = true,
          command = 'clippy',
        },
      },
    },
  },

  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}

require('mason').setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, cfg in pairs(servers) do
  cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
  vim.lsp.config(name, cfg)
end
require('mason-lspconfig').setup { automatic_enable = true }

-- vim: ts=2 sts=2 sw=2 et
