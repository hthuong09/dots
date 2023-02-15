require("nvim-autopairs").setup {}
local cmp_loaded, cmp = pcall(require, "cmp")
if cmp_loaded then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
