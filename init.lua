-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Core settings (leader must be set before any plugin is loaded)
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.diagnostics'

-- Plugin build hooks, then the plugins themselves
require 'config.pack'
require 'plugins'

-- vim: ts=2 sts=2 sw=2 et
