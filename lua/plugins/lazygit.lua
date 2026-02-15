return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- Lazy load on the command
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- Optional: setting up a keybinding for LazyGit
  keys = {
    { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  },
}
