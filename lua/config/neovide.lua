if not vim.g.neovide then
  return
end

vim.o.guifont = 'MesloLGS NF'
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_hide_mouse_when_typing = true
vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
vim.keymap.set('v', '<D-c>', '"+y') -- Copy
vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

-- Zoom in neovide
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<D-=>', function()
  change_scale_factor(1.15)
end)
vim.keymap.set('n', '<D-->', function()
  change_scale_factor(1 / 1.15)
end)
vim.keymap.set('n', '<D-0>', function()
  vim.g.neovide_scale_factor = 1.0
end)

-- vim: ts=2 sts=2 sw=2 et
