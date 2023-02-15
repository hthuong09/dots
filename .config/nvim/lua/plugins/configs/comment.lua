require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
vim.keymap.set(
  'n',
  '<leader>/',
  function()
    require("Comment.api").toggle.linewise.current()
  end,
  { desc = "Comment line" }
)
vim.keymap.set(
  'v',
  '<leader>/',
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
  { desc = "Comment block" }
)
