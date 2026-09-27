-- [[ diffview ]]
--  Side-by-side diffs for all changed files, file history and merge conflict
--  resolution in a single tab. Also powers Neogit's diff view.
--  See `:help diffview`
--
--  NOTE: This is the maintained fork (diffview+); the original
--  sindrets/diffview.nvim is no longer updated. The Lua module is still `diffview`.
vim.pack.add { 'https://github.com/dlyongemallo/diffview-plus.nvim' }

require('diffview').setup {
  use_icons = vim.g.have_nerd_font,
}

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Git [d]iff view' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = 'Git file [h]istory' })
vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<CR>', { desc = 'Git repo [H]istory' })
vim.keymap.set('n', '<leader>gq', '<cmd>DiffviewClose<CR>', { desc = 'Git [q]uit diff view' })
