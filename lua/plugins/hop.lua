local hop = require 'hop'

hop.setup {
  keys = 'etovxqpdygfblzhckisuran',
}

vim.keymap.set('n', '<leader>w', hop.hint_words, { desc = 'HopWord' })
vim.keymap.set('n', '<leader>fn', '<cmd>HopNodes<CR>', { desc = 'HopNodes' })

-- vim: ts=2 sts=2 sw=2 et
