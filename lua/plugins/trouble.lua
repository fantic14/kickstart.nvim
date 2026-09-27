-- [[ trouble.nvim ]]
--  A pretty list for diagnostics, references, symbols, quickfix and more.
--  See `:help trouble`
--
--  NOTE: Tracks the default branch; the last tagged release predates fixes
--  needed for Neovim 0.11+.
vim.pack.add { 'https://github.com/folke/trouble.nvim' }

require('trouble').setup {}

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xs', '<cmd>Trouble symbols toggle focus=false<CR>', { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>', { desc = 'LSP Definitions / references (Trouble)' })
vim.keymap.set('n', '<leader>xL', '<cmd>Trouble loclist toggle<CR>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', '<cmd>Trouble qflist toggle<CR>', { desc = 'Quickfix List (Trouble)' })
