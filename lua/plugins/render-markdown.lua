-- [[ render-markdown.nvim ]]
--  Renders Markdown inside the buffer: headings, tables, code blocks, checkboxes,
--  quotes. The line under the cursor shows the raw text again, so you can edit.
--  See `:help render-markdown`
vim.pack.add { { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', version = vim.version.range '8.*' } }

---@type render.md.UserConfig
local opts = {
  -- Completions for checkboxes and callouts, via blink.cmp's `lsp` source
  completions = { lsp = { enabled = true } },
  -- LaTeX math needs external tools (utftex / latex2text) and the latex parser
  latex = { enabled = false },
}

-- The defaults use Nerd Font glyphs; fall back to plain Unicode without one
if not vim.g.have_nerd_font then
  opts = vim.tbl_deep_extend('force', opts, {
    heading = {
      icons = { '◆ ', '◇ ', '● ', '○ ', '▸ ', '▹ ' },
      sign = false,
    },
    checkbox = {
      unchecked = { icon = '☐ ' },
      checked = { icon = '☑ ' },
    },
    link = { enabled = false },
    code = { sign = false },
  })
end

require('render-markdown').setup(opts)

vim.keymap.set('n', '<leader>tm', function() require('render-markdown').toggle() end, { desc = '[T]oggle [M]arkdown rendering' })
