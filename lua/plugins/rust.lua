-- Rust support: rustaceanvim configures rust-analyzer for us.
-- Do NOT also enable `rust_analyzer` in the kickstart `servers` table,
-- or two clients will attach and fight each other.

vim.pack.add { { src = 'https://github.com/mrcjkb/rustaceanvim', version = vim.version.range '9.*' } }

vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ['rust-analyzer'] = {
        check = { command = 'clippy' }, -- use clippy instead of plain `cargo check`
      },
    },
  },
}

-- Rust-specific keymaps, set only in Rust buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function(event)
    local map = function(keys, cmd, desc) vim.keymap.set('n', keys, cmd, { buffer = event.buf, desc = 'Rust: ' .. desc }) end
    map('<leader>rr', function() vim.cmd.RustLsp 'runnables' end, '[R]un [R]unnables')
    map('<leader>rt', function() vim.cmd.RustLsp 'testables' end, '[R]un [T]estables')
    map('<leader>re', function() vim.cmd.RustLsp 'expandMacro' end, '[R]ust [E]xpand macro')
    map('K', function() vim.cmd.RustLsp { 'hover', 'actions' } end, 'Hover actions')
  end,
})
