local M = {}

M.setup = function()
  local loaded, Comment = pcall(require, "Comment")
  if not loaded then
    return
  end
  local utils = require "Comment.utils"
  Comment.setup {
    pre_hook = function(ctx)
      local location = nil
      if ctx.ctype == utils.ctype.blockwise then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == utils.cmotion.v or ctx.cmotion == utils.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring {
        key = ctx.ctype == utils.ctype.linewise and "__default" or "__multiline",
        location = location,
      }
    end,
  }
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  maps.n["<leader>/"] = {
    function()
      require("Comment.api").toggle.linewise.current()
    end,
    desc = "Comment line",
  }
  maps.v["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Toggle comment line",
  }
  require("core.utils").set_mappings(maps)
end

return M
