return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup {
        options = {
          dim_inactive = true,
        },
        palettes = {
          -- Custom duskfox with black background
          github_dark = {
            -- white = '#ff0000',
            bg1 = '#FFFFFF', -- White background
            bg0 = '#FFFFFF', -- Alt backgrounds (floats, statusline, ...)
            bg3 = '#121820', -- 55% darkened from stock
            sel0 = '#131b24', -- 55% darkened from stock
          },
        },
        specs = {
          all = {
            inactive = 'bg0', -- Default value for other styles
          },
          github_dark = {
            inactive = '#090909', -- Slightly lighter then black background
          },
        },
        -- groups = {
        --   all = {
        --     NormalNC = { fg = 'fg1', bg = 'inactive' }, -- Non-current windows
        --   },
        -- },
      }
      -- require('github-theme').setup {}
    end,
  },
}
