-- Each plugin lives in its own file in this directory.
--  They are required explicitly so load order is deterministic:
--  e.g. the colorscheme loads first, and luasnip loads before blink.cmp.
--
--  To add a plugin: create `lua/plugins/<name>.lua` and add it to this list.

-- UI
require 'plugins.colorscheme'
require 'plugins.mini'
require 'plugins.which-key'
require 'plugins.todo-comments'

-- Editing
require 'plugins.guess-indent'

-- Search & navigation
require 'plugins.telescope'
require 'plugins.oil'
require 'plugins.harpoon'

-- Git (diffview before neogit, so neogit's diffview integration finds it)
require 'plugins.gitsigns'
require 'plugins.diffview'
require 'plugins.neogit'

-- LSP, formatting, completion
require 'plugins.fidget'
require 'plugins.lsp'
require 'plugins.trouble'
require 'plugins.conform'
require 'plugins.luasnip'
require 'plugins.blink'

-- Syntax
require 'plugins.treesitter'

-- Languages
require 'plugins.rust'
require 'plugins.crates'

-- Optional kickstart examples (see `lua/kickstart/plugins/`)
-- require 'kickstart.plugins.debug'
-- require 'kickstart.plugins.indent_line'
-- require 'kickstart.plugins.lint'
-- require 'kickstart.plugins.autopairs'
-- require 'kickstart.plugins.neo-tree'
