-- Neovim 0.12+ config using the built-in plugin manager (vim.pack).
--   :lua vim.pack.update()   update plugins (review, then :write to confirm)
--   :checkhealth vim.pack    plugin status
-- Plugin list lives in lua/plugins/init.lua; lockfile is nvim-pack-lock.json.

vim.loader.enable()

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.neovide'

require 'plugins'

vim.o.colorcolumn = '88'
vim.cmd 'filetype plugin indent on'

-- vim: ts=2 sts=2 sw=2 et
