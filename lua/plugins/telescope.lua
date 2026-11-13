-- Fuzzy Finder (files, lsp, etc)
--  Used for help/keymaps/diagnostics pickers, LSP pickers (gd, gr, ...) and harpoon.
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      '.git/',
      'node_modules/',
    },
  },
  pickers = {
    oldfiles = {
      cwd_only = true,
    },
    find_files = {
      hidden = true,
    },
    buffers = {
      mappings = {
        i = {
          ['<C-d>'] = 'delete_buffer',
        },
      },
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'live_grep_args')
pcall(require('telescope').load_extension, 'lazygit')

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- vim: ts=2 sts=2 sw=2 et
