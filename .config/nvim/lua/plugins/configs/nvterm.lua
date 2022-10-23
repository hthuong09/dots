local M = {}

M.setup = function()
  local present, nvterm = pcall(require, "nvterm")

  if not present then
    return
  end

  -- require "base46.term"

  local options = {
    terminals = {
      list = {},
      type_opts = {
        float = {
          relative = "editor",
          row = 0.3,
          col = 0.25,
          width = 0.5,
          height = 0.4,
          border = "single",
        },
        horizontal = { location = "rightbelow", split_ratio = 0.3 },
        vertical = { location = "rightbelow", split_ratio = 0.5 },
      },
    },
    behavior = {
      close_on_exit = true,
      auto_insert = true,
    },
    enable_new_mappings = true,
  }

  nvterm.setup(options)
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  maps.n["<leader>gg"] = {
    function()
      require("nvterm.terminal").send "lazygit" "float"
    end,
    desc = "Terminal lazygit",
  }
  maps.n["<leader>tn"] = {
    function()
      require("nvterm.terminal").send("node", "float")
    end,
    desc = "Terminal node",
  }
  maps.n["<leader>tu"] = {
    function()
      require("nvterm.terminal").send "ncdu" "float"
    end,
    desc = "Terminal NCDU",
  }
  maps.n["<leader>tt"] = {
    function()
      require("nvterm.terminal").send "htop" "float"
    end,
    desc = "Terminal htop",
  }
  maps.n["<leader>tl"] = {
    function()
      require("nvterm.terminal").send "lazygit"
    end,
    desc = "Terminal lazygit",
  }
  maps.n["<leader>tf"] = {
    function()
      require("nvterm.terminal").toggle "float"
    end,
    desc = "Terminal float",
  }
  maps.n["<leader>th"] = {
    function()
      require("nvterm.terminal").toggle "horizontal"
    end,
    desc = "Terminal horizontal split",
  }
  maps.n["<leader>tv"] = {
    function()
      require("nvterm.terminal").toggle "vertical"
    end,
    desc = "Terminal vertical split",
  }

  require("core.utils").set_mappings(maps)
end

return M
