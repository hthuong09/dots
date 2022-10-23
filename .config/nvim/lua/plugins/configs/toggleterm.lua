local M = {}

M.user_terminals = {}

M.setup = function()
  local loaded, toggleterm = pcall(require, "toggleterm")
  if not loaded then
    return
  end
  toggleterm.setup {
    size = 10,
    open_mapping = [[<c-\>]],
    shading_factor = 2,
    direction = "float",
    float_opts = {
      border = "curved",
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  }
end

M.toggle_term_cmd = function(term_details)
  if type(term_details) == "string" then
    term_details = { cmd = term_details, hidden = true }
  end
  local term_key = term_details.cmd
  if vim.v.count > 0 and term_details.count == nil then
    term_details.count = vim.v.count
    term_key = term_key .. vim.v.count
  end
  if M.user_terminals[term_key] == nil then
    M.user_terminals[term_key] = require("toggleterm.terminal").Terminal:new(term_details)
  end
  M.user_terminals[term_key]:toggle()
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  local toggle_term_cmd = M.toggle_term_cmd
  maps.n["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
  maps.n["<leader>gg"] = {
    function()
      toggle_term_cmd "lazygit"
    end,
    desc = "ToggleTerm lazygit",
  }
  maps.n["<leader>tn"] = {
    function()
      toggle_term_cmd "node"
    end,
    desc = "ToggleTerm node",
  }
  maps.n["<leader>tu"] = {
    function()
      toggle_term_cmd "ncdu"
    end,
    desc = "ToggleTerm NCDU",
  }
  maps.n["<leader>tp"] = {
    function()
      toggle_term_cmd "python"
    end,
    desc = "ToggleTerm python",
  }
  maps.n["<leader>tl"] = {
    function()
      toggle_term_cmd "lazygit"
    end,
    desc = "ToggleTerm lazygit",
  }
  maps.n["<leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" }
  maps.n["<leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" }
  maps.n["<leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" }
  maps.n["<leader>tt"] = { "<cmd>ToggleTerm size=80 direction=tab<cr>", desc = "ToggleTerm tab" }
  require("core.utils").set_mappings(maps)
end

return M
