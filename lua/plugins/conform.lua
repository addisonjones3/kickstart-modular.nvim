-- Autoformat
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = {}
    local lsp_format_opt

    if disable_filetypes[vim.bo[bufnr].filetype] then
      lsp_format_opt = 'never'
    else
      lsp_format_opt = 'fallback'
    end
    return {
      timeout_ms = 1000000,
      lsp_format = lsp_format_opt,
    }
  end,
  formatters_by_ft = {
    c = { 'clang_format' },
    lua = { 'stylua' },
    bazel = { 'buildifier' },
    bzl = { 'buildifier' },
    json = { 'jq' },
    sh = { 'shfmt' },
    WORKSPACE = { 'buildifier' },
  },
  formatters = {
    shfmt = {
      append_args = {
        '-ln',
        'bash',
        '-i',
        '4',
        '-fn',
      },
    },
    goimports = {
      prepend_args = { '-local', 'edge-infra.dev' },
    },
    clang_format = {
      prepend_args = { '--style=file', '--fallback-style=LLVM' },
    },
  },
}

vim.keymap.set('', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

-- vim: ts=2 sts=2 sw=2 et
