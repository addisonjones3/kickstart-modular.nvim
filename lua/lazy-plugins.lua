-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/cmp',

  require 'kickstart/plugins/tokyonight',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/treesitter',

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',

  require 'kickstart.plugins.autopairs',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  {
    require 'custom.plugins.neo-tree',

    require 'custom.plugins.themes.github-dark',

    require 'custom.plugins.vim-surround',

    require 'custom.plugins.vim-commentary',

    require 'custom.plugins.lua-line',

    require 'custom.plugins.git-blame',

    require 'custom.plugins.markdown-preview',

    require 'custom.plugins.trouble',

    require 'custom.plugins.quick-scope',

    require 'custom.plugins.hop',

    require 'custom.plugins.d2-vim',

    require 'custom.plugins.indent',
  },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

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
