-- [[ LuaSnip ]]
--  Snippet engine, used as blink.cmp's snippet source.
vim.pack.add { { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }

require('luasnip').setup {}

-- Premade snippets for many languages: https://github.com/rafamadriz/friendly-snippets
-- vim.pack.add { 'https://github.com/rafamadriz/friendly-snippets' }
-- require('luasnip.loaders.from_vscode').lazy_load()
