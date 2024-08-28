return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          refresh = {
            statusline = 100,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { { 'filename', path = 1 } },
          lualine_c = {},
          -- lualine_x = {},
          -- lualine_y = {},
          -- lualine_z = { 'tabs' },
        },
        inactive_sections = {
          lualine_c = { { 'filename', path = 1 } },
        },
        tabline = {
          lualine_a = { 'branch' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'tabs' },
        },
      }
    end,
  },
}
