-- [[ crates.nvim ]]
--  Manage Rust dependencies in `Cargo.toml`: inline latest versions, popups,
--  and upgrades. See `:help crates`
--
--  Runs as an in-process language server, so completion (crate names, versions,
--  features) goes through blink.cmp's `lsp` source, code actions through `gra`
--  and hover through `K`.
--
--  NOTE: Tracks the default branch; the `stable` tag lacks a fix for when
--  `winborder` is not set.
vim.pack.add { 'https://github.com/saecki/crates.nvim' }

local crates = require 'crates'

crates.setup {
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
  completion = {
    crates = { enabled = true }, -- Complete crate names from crates.io search
  },
}

-- Keymaps, set only in `Cargo.toml` buffers
vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('config-crates-keymaps', { clear = true }),
  pattern = 'Cargo.toml',
  callback = function(event)
    local map = function(mode, keys, func, desc) vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'Crates: ' .. desc }) end

    map('n', '<leader>cv', crates.show_versions_popup, 'Show [v]ersions')
    map('n', '<leader>cf', crates.show_features_popup, 'Show [f]eatures')
    map('n', '<leader>cd', crates.show_dependencies_popup, 'Show [d]ependencies')
    map('n', '<leader>cu', crates.update_crate, '[u]pdate crate')
    map('v', '<leader>cu', crates.update_crates, '[u]pdate crates')
    map('n', '<leader>ca', crates.update_all_crates, 'Update [a]ll crates')
    map('n', '<leader>cU', crates.upgrade_crate, '[U]pgrade crate')
    map('v', '<leader>cU', crates.upgrade_crates, '[U]pgrade crates')
    map('n', '<leader>cA', crates.upgrade_all_crates, 'Upgrade [A]ll crates')
    map('n', '<leader>cD', crates.open_documentation, 'Open [D]ocumentation')
    map('n', '<leader>cC', crates.open_crates_io, 'Open [C]rates.io')
  end,
})
