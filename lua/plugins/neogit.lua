-- [[ Neogit ]]
--  A Magit-style git interface: stage, commit, push, pull, rebase, branch...
--  Press `?` inside Neogit to see every action. See `:help neogit`
--  Requires plenary.nvim; uses diffview and telescope when loaded before it.
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/NeogitOrg/neogit',
}

local neogit = require 'neogit'

neogit.setup {
  integrations = {
    diffview = true,
    telescope = true,
  },
}

vim.keymap.set('n', '<leader>gg', function() neogit.open() end, { desc = '[G]it status (Neogit)' })
vim.keymap.set('n', '<leader>gc', function() neogit.open { 'commit' } end, { desc = 'Git [c]ommit' })
vim.keymap.set('n', '<leader>gl', function() neogit.open { 'log' } end, { desc = 'Git [l]og' })
