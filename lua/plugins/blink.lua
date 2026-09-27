-- [[ blink.cmp ]]
--  Autocompletion. See `:help blink-cmp` and `:help ins-completion`
vim.pack.add { { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' } }

require('blink.cmp').setup {
  keymap = {
    -- 'default': <c-y> to accept, 'super-tab': tab to accept, 'enter': enter to accept, 'none'
    --
    -- All presets have:
    --  <tab>/<s-tab>: move to right/left of your snippet expansion
    --  <c-space>: Open menu or open docs if already open
    --  <c-n>/<c-p> or <up>/<down>: Select next/previous item
    --  <c-e>: Hide menu
    --  <c-k>: Toggle signature help
    --
    -- See `:help blink-cmp-config-keymap` for defining your own keymap
    preset = 'default',
  },

  appearance = {
    -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    nerd_font_variant = 'mono',
  },

  completion = {
    -- Press <c-space> to show docs, or set `auto_show = true`
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },

  snippets = { preset = 'luasnip' },

  -- Use 'prefer_rust_with_warning' for the faster (downloaded) Rust fuzzy matcher.
  --  See `:help blink-cmp-config-fuzzy`
  fuzzy = { implementation = 'lua' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}
