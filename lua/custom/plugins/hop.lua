return {
  'smoka7/hop.nvim',
  version = '*',
  opts = {},
  config = function()
    local hop = require 'hop'
    local directions = require('hop.hint').HintDirection

    hop.setup {
      keys = 'etovxqpdygfblzhckisuran',
    }

    vim.keymap.set('n', '<leader>fw', hop.hint_words, { desc = 'HopWord' })
    vim.keymap.set('n', '<leader>fn', '<cmd>HopNodes<CR>', { desc = 'HopNodes' })
    vim.keymap.set('', 'f', function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
    end, { remap = true, desc = 'Find Char 1' })
    vim.keymap.set('', 'F', function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
    end, { remap = true, desc = 'Backwards Find Char 1' })
  end,
}
