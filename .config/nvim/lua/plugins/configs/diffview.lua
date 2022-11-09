local M = {}

function M.setup()
  local loaded, diffview = pcall(require, "diffview")
  if not loaded then
    return
  end
  -- highlight https://github.com/sindrets/dotfiles/blob/master/.config/nvim/lua/user/plugins/diffview.lua#L61-L84
  diffview.setup {
    enhanced_diff_hl = true,
  }
end

function M.load_keymaps()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  -- TODO: enhance this to toggle git diff window
  maps.n["<leader>gd"] = {
    "<cmd>DiffviewOpen<cr>",
    desc = "Open Git Diff",
  }
  maps.n["<leader>gq"] = {
    "<cmd>DiffviewClose<cr>",
    desc = "Close Git Diff",
  }
  require("core.utils").set_mappings(maps)
end

return M
