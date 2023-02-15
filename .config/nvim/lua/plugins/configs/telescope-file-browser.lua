local M = {}

M.setup = function()
  local loaded, telescope = pcall(require, "telescope")
  if not loaded then
    return
  end

  telescope.load_extension "file_browser"
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {},[""] = {} }
  maps.n["<leader>e"] = {
    "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ cwd_to_path = true, path = vim.fn.expand('%:p:h') })<CR>",
    desc = "File Browser",
  }
  require("core.utils").set_mappings(maps)
end

return M
