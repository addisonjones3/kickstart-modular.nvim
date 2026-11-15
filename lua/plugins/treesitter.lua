-- Highlight, edit, and navigate code
--  nvim-treesitter `main` branch: it only installs parsers/queries. Highlighting and
--  indent are turned on per-buffer below (replaces the old `highlight`/`indent`/`auto_install`).
local ts = require 'nvim-treesitter'

ts.install {
  'bash',
  'c',
  'diff',
  'go',
  'gomod',
  'gosum',
  'html',
  'just',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'rust',
  'vim',
  'vimdoc',
}

-- Languages that keep vim regex highlighting alongside treesitter, and skip treesitter indent
local regex_highlight = { ruby = true }
local no_indent = { ruby = true }

local available -- lazily computed list of parsers nvim-treesitter can install

local function attach(buf, lang)
  if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
    return
  end
  if regex_highlight[lang] then
    vim.bo[buf].syntax = 'on'
  end
  if not no_indent[lang] then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then
      return
    end

    if vim.treesitter.language.add(lang) then
      attach(ev.buf, lang)
      return
    end

    -- auto_install: fetch missing parsers the first time a filetype is opened
    available = available or ts.get_available()
    if vim.tbl_contains(available, lang) then
      ts.install({ lang }):await(function(err)
        if not err then
          vim.schedule(function()
            attach(ev.buf, lang)
          end)
        end
      end)
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
