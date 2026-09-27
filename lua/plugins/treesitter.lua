-- [[ Treesitter ]]
--  Highlight, edit, and navigate code. See `:help nvim-treesitter-intro`
vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } }

local ts = require 'nvim-treesitter'

-- Parsers to always have installed; others are installed on demand
ts.install { 'bash', 'c', 'rust', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }

---@param buf integer
---@param language string
local function try_attach(buf, language)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then return end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)

  -- Treesitter based folds. See `:help folds`
  -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- vim.wo.foldmethod = 'expr'

  -- Treesitter based indentation, if the language has an indent query
  if vim.treesitter.query.get(language, 'indents') ~= nil then vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = ts.get_available()

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('config-treesitter', { clear = true }),
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    if vim.tbl_contains(ts.get_installed 'parsers', language) then
      try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- Auto-install the parser, then attach once it's ready
      ts.install(language):await(function() try_attach(buf, language) end)
    else
      -- The parser may exist outside of nvim-treesitter
      try_attach(buf, language)
    end
  end,
})
