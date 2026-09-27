-- [[ LSP ]]
--  nvim-lspconfig provides server configs, mason installs the servers/tools.
--  See `:help lsp-config` and `:help lsp-vs-treesitter`
--
--  NOTE: Rust is handled by rustaceanvim (see `plugins/rust.lua`).
--  Do NOT add `rust_analyzer` below, or two clients will attach.

vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
}

-- Language servers to enable. They are installed automatically via Mason.
---@type table<string, vim.lsp.Config>
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- tsc = {},

  stylua = {}, -- Used to format Lua code

  -- Special Lua config, as recommended by neovim help docs
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Formatting is done by stylua

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
      client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.api.nvim_get_runtime_file('', true),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        format = { enable = false }, -- Formatting is done by stylua
      },
    },
  },
}

-- Other tools (formatters, linters) for Mason to install
local tools = {}

require('mason').setup {}

-- Translates between lspconfig and mason package names (e.g. lua_ls <-> lua-language-server)
require('mason-lspconfig').setup {
  automatic_enable = false, -- Set to true to also enable servers installed manually via :Mason
}

local ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools)
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- Buffer-local setup, run whenever an LSP attaches to a buffer.
--  Navigation pickers (grr, grd, ...) are set in `plugins/telescope.lua`.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    -- WARN: This is Goto Declaration, not Definition (e.g. in C this jumps to the header).
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- Highlight references of the word under the cursor when it rests there,
    -- and clear them when the cursor moves. See `:help CursorHold`
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('config-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('config-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'config-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    -- Toggle inlay hints, if the server supports them
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    end
  end,
})
