-- [[ harpoon (v2) ]]
--  Mark the handful of files you're working on and jump between them instantly.
--  In the menu, edit the list like a normal buffer (reorder with dd/p, delete lines).
--  Requires plenary.nvim (installed by `plugins/telescope.lua`).
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'

harpoon:setup {}

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon: [A]dd file' })
vim.keymap.set('n', '<leader>e', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: M[e]nu' })

for i = 1, 4 do
  vim.keymap.set('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon: File ' .. i })
end
