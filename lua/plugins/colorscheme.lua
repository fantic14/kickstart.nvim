-- [[ Colorscheme ]]
--  Other styles: 'tokyonight-storm', 'tokyonight-moon', 'tokyonight-day'.
--  Browse installed colorschemes with `:Telescope colorscheme`.
vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }

---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}

vim.cmd.colorscheme 'tokyonight-night'
