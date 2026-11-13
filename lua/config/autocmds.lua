-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Re-enable netrw for remote files (sftp://, scp://, ...) since neo-tree disables it
vim.api.nvim_create_autocmd('BufNewFile', {
  group = vim.api.nvim_create_augroup('RemoteFile', { clear = true }),
  callback = function()
    local f = vim.fn.expand '%:p'
    for _, v in ipairs { 'sftp', 'scp', 'ssh', 'dav', 'fetch', 'ftp', 'http', 'rcp', 'rsync' } do
      local p = v .. '://'
      if string.sub(f, 1, #p) == p then
        vim.cmd [[
          unlet g:loaded_netrw
          unlet g:loaded_netrwPlugin
          runtime! plugin/netrwPlugin.vim
          silent Explore %
        ]]
        vim.api.nvim_clear_autocmds { group = 'RemoteFile' }
        break
      end
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
