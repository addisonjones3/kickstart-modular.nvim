-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  config = function()
    require('neo-tree').setup {
      window = {
        position = 'right',
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_gotfiles = false,
          hide_by_name = {},
          never_show = {
            '.git',
            '.DS_Store',
          },
        },
        hijack_netrw_behavior = 'open_current',
        window = {
          mappings = {
            ['<leader>e'] = 'close_window',
            ['l'] = 'toggle_node',
            ['K'] = 'close_all_nodes',
            ['h'] = 'close_node',
          },
        },
      },
    }
  end,
  opts = {},
}
