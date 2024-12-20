return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local function window()
        return vim.api.nvim_win_get_number(0)
      end
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
          lualine_a = { { window, color = { fg = '#26ffbb', bg = '#282828' } } },
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
