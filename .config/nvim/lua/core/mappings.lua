local is_available = require("core.utils").is_available

-- replace :q with :close to prevent accidentally quit vim
vim.cmd "cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>"

local maps = { n = {}, v = {}, t = {}, i = {}, [""] = {} }

maps[""]["<Space>"] = "<Nop>"

-- Normal --
-- Standard Operations
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>q"] = { "<cmd>q<cr>", desc = "Quit" }
maps.n["<leader>h"] = { "<cmd>nohlsearch<cr>", desc = "No Highlight" }
maps.n["<esc>"] = { "<cmd>nohlsearch<cr>", desc = "No Highlight" }
maps.i["<M-BS>"] = { "<C-W>", desc = "Option+backspace delete word" }
maps.i["<C-BS>"] = { "<C-W>", desc = "Control+backspace delete word" }
-- TODO: copy URL toggle from astronvim
maps.n["<leader>u"] = {
  function()
    M.toggle_url_match()
  end,
  desc = "Toggle URL Highlights",
}
maps.n["<leader>fn"] = { "<cmd>enew<cr>", desc = "New File" }
maps.n["gx"] = {
  function()
    M.url_opener()
  end,
  desc = "Open the file under cursor with system app",
}
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }
maps.n["Q"] = "<Nop>"

-- Packer
maps.n["<leader>pc"] = { "<cmd>PackerCompile<cr>", desc = "Packer Compile" }
maps.n["<leader>pi"] = { "<cmd>PackerInstall<cr>", desc = "Packer Install" }
maps.n["<leader>ps"] = { "<cmd>PackerSync<cr>", desc = "Packer Sync" }
maps.n["<leader>pS"] = { "<cmd>PackerStatus<cr>", desc = "Packer Status" }
maps.n["<leader>pu"] = { "<cmd>PackerUpdate<cr>", desc = "Packer Update" }

maps.n["<leader>c"] = {
  function()
    local bufs = vim.fn.getbufinfo { buflisted = true }
    require("core.utils").close_buffer()
    if require("core.utils").is_available "alpha-nvim" and not bufs[2] then
      require("alpha").start(true)
      vim.opt.showtabline = 1
    end
  end,
  desc = "Close window",
}

-- GitSigns
if is_available "gitsigns.nvim" then
  maps.n["<leader>gj"] = {
    function()
      require("gitsigns").next_hunk()
    end,
    desc = "Next git hunk",
  }
  maps.n["<leader>gk"] = {
    function()
      require("gitsigns").prev_hunk()
    end,
    desc = "Previous git hunk",
  }
  maps.n["<leader>gl"] = {
    function()
      require("gitsigns").blame_line()
    end,
    desc = "View git blame",
  }
  maps.n["<leader>gp"] = {
    function()
      require("gitsigns").preview_hunk()
    end,
    desc = "Preview git hunk",
  }
  maps.n["<leader>gh"] = {
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "Reset git hunk",
  }
  maps.n["<leader>gr"] = {
    function()
      require("gitsigns").reset_buffer()
    end,
    desc = "Reset git buffer",
  }
  maps.n["<leader>gs"] = {
    function()
      require("gitsigns").stage_hunk()
    end,
    desc = "Stage git hunk",
  }
  maps.n["<leader>gu"] = {
    function()
      require("gitsigns").undo_stage_hunk()
    end,
    desc = "Unstage git hunk",
  }
  maps.n["<leader>gd"] = {
    function()
      require("gitsigns").diffthis()
    end,
    desc = "View git diff",
  }
end

-- Package Manager
-- TODO: v2 rework these key bindings to be more general
-- TODO: moving this config to plugin specified map
if is_available "mason.nvim" then
  maps.n["<leader>lI"] = { "<cmd>Mason<cr>", desc = "LSP installer" }
end

-- LSP Installer
if is_available "mason-lspconfig.nvim" then
  maps.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" }
end

-- Smart Splits
if is_available "smart-splits.nvim" then
  -- Better window navigation
  maps.n["<C-h>"] = {
    function()
      require("smart-splits").move_cursor_left()
    end,
    desc = "Move to left split",
  }
  maps.n["<C-j>"] = {
    function()
      require("smart-splits").move_cursor_down()
    end,
    desc = "Move to below split",
  }
  maps.n["<C-k>"] = {
    function()
      require("smart-splits").move_cursor_up()
    end,
    desc = "Move to above split",
  }
  maps.n["<C-l>"] = {
    function()
      require("smart-splits").move_cursor_right()
    end,
    desc = "Move to right split",
  }

  -- Resize with arrows
  maps.n["<C-Up>"] = {
    function()
      require("smart-splits").resize_up()
    end,
    desc = "Resize split up",
  }
  maps.n["<C-Down>"] = {
    function()
      require("smart-splits").resize_down()
    end,
    desc = "Resize split down",
  }
  maps.n["<C-Left>"] = {
    function()
      require("smart-splits").resize_left()
    end,
    desc = "Resize split left",
  }
  maps.n["<C-Right>"] = {
    function()
      require("smart-splits").resize_right()
    end,
    desc = "Resize split right",
  }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "unindent line" }
maps.v[">"] = { ">gv", desc = "indent line" }

-- Improved Terminal Mappings
maps.t["<esc>"] = { "<C-\\><C-n>", desc = "Terminal normal mode" }
maps.t["jk"] = { "<C-\\><C-n>", desc = "Terminal normal mode" }
maps.t["<C-h>"] = { "<c-\\><c-n><c-w>h", desc = "Terminal left window navigation" }
maps.t["<C-j>"] = { "<c-\\><c-n><c-w>j", desc = "Terminal down window navigation" }
maps.t["<C-k>"] = { "<c-\\><c-n><c-w>k", desc = "Terminal up window navigation" }
maps.t["<C-l>"] = { "<c-\\><c-n><c-w>l", desc = "Terminal right window naviation" }
require("core.utils").set_mappings(maps)
