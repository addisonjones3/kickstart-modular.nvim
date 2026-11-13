-- [[ Plugins ]]
--  Managed by the built-in vim.pack (see `:help vim.pack`).
--
--  Add a plugin:    add it to the list below (+ a lua/plugins/<name>.lua if it needs setup)
--  Update plugins:  :lua vim.pack.update()       (review, then :write to confirm)
--  Remove a plugin: delete it below, restart, then :lua vim.pack.del { 'name' }

local gh = function(repo)
  return 'https://github.com/' .. repo
end

-- Build steps: must be registered before vim.pack.add() so they run on first install
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack-build-hooks', { clear = true }),
  callback = function(ev)
    local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path
    if kind ~= 'install' and kind ~= 'update' then
      return
    end

    local function run(cmd)
      local res = vim.system(cmd, { cwd = path }):wait()
      if res.code ~= 0 then
        vim.notify(('Build failed for %s:\n%s'):format(name, res.stderr), vim.log.levels.ERROR)
      end
    end

    if name == 'LuaSnip' and vim.fn.executable 'make' == 1 then
      run { 'make', 'install_jsregexp' }
    elseif name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run { 'make' }
    elseif name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.pack.add({
  -- Shared dependencies
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-tree/nvim-web-devicons',
  gh 'MunifTanjim/nui.nvim',

  -- Colorscheme
  { src = gh 'catppuccin/nvim', name = 'catppuccin' },

  -- UI
  gh 'folke/which-key.nvim',
  gh 'nvim-lualine/lualine.nvim',
  gh 'nvim-mini/mini.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'folke/trouble.nvim',
  { src = gh 'nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },

  -- Search / navigation
  { src = gh 'nvim-telescope/telescope.nvim', version = vim.version.range '0.2' },
  gh 'nvim-telescope/telescope-fzf-native.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
  gh 'nvim-telescope/telescope-live-grep-args.nvim',
  gh 'ibhagwan/fzf-lua',
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
  { src = gh 'smoka7/hop.nvim', version = vim.version.range '*' },
  gh 'unblevable/quick-scope',

  -- Editing
  gh 'tpope/vim-surround',
  gh 'tpope/vim-commentary',
  gh 'windwp/nvim-autopairs',
  gh 'Darazaki/indent-o-matic',
  gh 'terrastruct/d2-vim',

  -- Git
  gh 'lewis6991/gitsigns.nvim',
  gh 'f-person/git-blame.nvim',

  -- Treesitter
  gh 'nvim-treesitter/nvim-treesitter',

  -- Completion
  gh 'hrsh7th/nvim-cmp',
  gh 'L3MON4D3/LuaSnip',
  gh 'saadparwaiz1/cmp_luasnip',
  gh 'hrsh7th/cmp-nvim-lsp',
  gh 'hrsh7th/cmp-path',

  -- LSP / formatting / linting
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'j-hui/fidget.nvim',
  gh 'folke/lazydev.nvim',
  gh 'Bilal2453/luvit-meta',
  gh 'stevearc/conform.nvim',
  gh 'mfussenegger/nvim-lint',
}, { confirm = false })

-- Plugin setup (+ their keymaps). Order matters where noted.
require 'plugins.catppuccin' -- colorscheme first
require 'plugins.gitsigns'
require 'plugins.which-key'
require 'plugins.telescope'
require 'plugins.lspconfig'
require 'plugins.conform'
require 'plugins.cmp'
require 'plugins.todo-comments'
require 'plugins.mini'
require 'plugins.treesitter'
require 'plugins.lint'
require 'plugins.autopairs' -- after cmp
require 'plugins.fzf'
require 'plugins.harpoon' -- after telescope
require 'plugins.neo-tree'
require 'plugins.lualine' -- after mini (overrides mini.statusline)
require 'plugins.git-blame'
require 'plugins.trouble'
require 'plugins.hop'
require 'plugins.indent-o-matic'

-- vim: ts=2 sts=2 sw=2 et
