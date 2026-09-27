-- [[ mini.nvim ]]
--  A collection of various small independent plugins/modules
--  See https://github.com/nvim-mini/mini.nvim
vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  -- Avoid conflicts with the built-in incremental selection mappings (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--  - sd'   - [S]urround [D]elete [']quotes
--  - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- Simple and easy statusline.
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }

-- Show cursor location as LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end
