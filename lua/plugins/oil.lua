-- [[ oil.nvim ]]
--  Edit the filesystem like a buffer: rename, move or delete files with normal
--  text edits, then `:w` to apply. See `:help oil`
--
--  Inside oil: <CR> open, - parent dir, _ cwd, g. toggle hidden, g? help
vim.pack.add { { src = 'https://github.com/stevearc/oil.nvim', version = vim.version.range '2.*' } }

require('oil').setup {
  -- Open directories (e.g. `nvim .`) in oil instead of netrw
  default_file_explorer = true,
  -- Icons need a Nerd Font (see `vim.g.have_nerd_font`)
  columns = vim.g.have_nerd_font and { 'icon' } or {},
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    -- Keep <C-h>/<C-l> for window navigation (see `config/keymaps.lua`),
    -- and move oil's split / refresh actions to other keys.
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['<C-x>'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-r>'] = 'actions.refresh',
  },
}

vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
