local M = {
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function()
      local fzf = require 'fzf-lua'
      local fzf_actions = require 'fzf-lua.actions'
      fzf.setup {
        keymap = {
          fzf = {
            ['ctrl-d'] = 'half-page-down',
            ['ctrl-u'] = 'half-page-up',
          },
        },
        actions = {
          files = {
            ['enter'] = fzf_actions.file_edit_or_qf,
            ['ctrl-s'] = fzf_actions.file_split,
            ['ctrl-v'] = fzf_actions.file_vsplit,
          },
        },
        oldfiles = {
          cwd_only = true,
        },
      }

      vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = '[S]earch existing [B]uffers' })
      vim.keymap.set('n', '<leader>sg', fzf.live_grep_glob, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = '[S]earch in current buffer' })
      vim.keymap.set('n', '<leader>s/', fzf.lines, { desc = '[S]earch open buffer lines' })
      vim.keymap.set('n', '<leader>sr', fzf.live_grep_resume, { desc = '[S]earch [R]esume' })
    end,
  },
}

return M
