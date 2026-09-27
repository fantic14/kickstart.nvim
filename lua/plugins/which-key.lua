-- [[ which-key.nvim ]]
--  Shows pending keybinds.
vim.pack.add { 'https://github.com/folke/which-key.nvim' }

require('which-key').setup {
  -- Delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { '<leader>r', group = '[R]ust' },
    { '<leader>c', group = '[C]rates (Cargo.toml)', mode = { 'n', 'v' } },
    { '<leader>g', group = '[G]it' },
    { '<leader>x', group = 'Trouble' },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
}
