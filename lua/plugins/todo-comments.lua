-- [[ todo-comments.nvim ]]
--  Highlight TODO, NOTE, etc. in comments
vim.pack.add { 'https://github.com/folke/todo-comments.nvim' }

require('todo-comments').setup { signs = false }
