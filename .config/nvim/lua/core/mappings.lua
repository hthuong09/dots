-- Set the map leader to space.
vim.g.mapleader = " "

-- Replace :q with :close to prevent accidentally quit vim
vim.cmd "cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>"

local maps = { n = {}, v = {}, t = {}, i = {},[""] = {} }

maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>q"] = { "<cmd>q<cr>", desc = "Quit" }
maps.n["<leader>h"] = { "<cmd>nohlsearch<cr>", desc = "No Highlight" }
maps.n["<esc>"] = { "<cmd>nohlsearch<cr>", desc = "No Highlight" }
maps.i["<M-BS>"] = { "<C-W>", desc = "Option+backspace delete word" }
maps.n["q"] = { "<nop>", desc = "Disable neovim recording" }
maps.n["<Tab>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
maps.n["<S-Tab>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }

maps.n["<leader>C"] = { function() require("bufdelete").bufdelete(0, true) end, desc = "Force close buffer" }
maps.n["<leader>c"] = {
  function()
    local bufs = vim.fn.getbufinfo { buflisted = true }
    require("bufdelete").bufdelete(0, false)
    if require("core.utils").is_available "alpha-nvim" and not bufs[2] then
      require("alpha").start(true)
      vim.opt.showtabline = 1
    end
  end
  ,
  desc = "Close buffer"
}

require('core.utils').set_mappings(maps)
