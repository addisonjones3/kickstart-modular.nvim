return {
  {
    'Darazaki/indent-o-matic',
    opts = {},
    config = function()
      require('indent-o-matic').setup {
        filetype_bazel = {
          standard_widths = { 4 },
        },
        filetype_bzl = {
          standard_widths = { 4 },
        },
      }
    end,
  },
}
