-- [[ conform.nvim ]]
--  Formatting. See `:help conform`
vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

-- Filetypes to autoformat on save
local format_on_save_filetypes = {
  rust = true,
  -- lua = true,
  -- python = true,
}

require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    if format_on_save_filetypes[vim.bo[bufnr].filetype] then return { timeout_ms = 500 } end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use formatters below if configured, otherwise LSP formatting
  },
  formatters_by_ft = {
    rust = { 'rustfmt' },
    -- Run multiple formatters sequentially:
    -- python = { "isort", "black" },
    -- Run the first available formatter:
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
