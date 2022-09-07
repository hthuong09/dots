vim.cmd "packadd packer.nvim"

local plugins = {
  -- Core
  ["nvim-lua/plenary.nvim"] = { module = "plenary" },
  ["wbthomason/packer.nvim"] = {
    cmd = {
      "PackerSnapshot",
      "PackerSnapshotRollback",
      "PackerSnapshotDelete",
      "PackerInstall",
      "PackerUpdate",
      "PackerSync",
      "PackerClean",
      "PackerCompile",
      "PackerStatus",
      "PackerProfile",
      "PackerLoad",
    },
    config = function()
      require "plugins"
    end,
  },
  ["NvChad/extensions"] = { module = { "telescope", "nvchad" } },

  -- UI
  ["NvChad/base46"] = {
    config = function()
      require "plugins.configs.nvchad-base46"
    end,
  },
  ["NvChad/ui"] = {
    after = "base46",
    config = function()
      require("plugins.configs.nvchad-ui").setup()
    end,
    setup = function()
      require("plugins.configs.nvchad-ui").load_keymaps()
    end,
  },
  ["kyazdani42/nvim-web-devicons"] = {
    after = "ui",
    module = "nvim-web-devicons",
    config = function()
      require "plugins.configs.devicons"
    end,
  },
  ["goolord/alpha-nvim"] = {
    after = "base46",
    config = function()
      require "plugins.configs.alpha"
    end,
  },

  ["NvChad/nvim-colorizer.lua"] = {
    config = function()
      require "plugins.configs.colorizer"
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    -- cmd = "Telescope", -- TODO: convert keymap to commad for lazy load to enable this
    config = function()
      require("plugins.configs.telescope").setup()
    end,
    setup = function()
      require("plugins.configs.telescope").load_keymaps()
    end,
  },

  -- misc
  -- TODO: This needs cmp for something, need to check
  ["windwp/nvim-autopairs"] = {
    -- after = "nvim-cmp", -- TODO: enabled this
    event = "InsertEnter",
    config = function()
      require "plugins.configs.autopairs"
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    run = ":TSUpdate",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    cmd = {
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSDisableAll",
      "TSEnableAll",
    },
    config = function()
      require "plugins.configs.treesitter"
    end,
  },

  -- TODO: depends on treesitter, it's not loaded by default so the keymap not loaded
  ["JoosepAlviste/nvim-ts-context-commentstring"] = { after = "nvim-treesitter" },
  ["numToStr/Comment.nvim"] = {
    module = { "Comment", "Comment.api" },
    keys = { "gc", "gb", "g<", "g>" },
    config = function()
      require('plugins.configs.comment').setup()
    end,
    setup = function()
      require('plugins.configs.comment').load_keymaps()
    end
  },

  -- TODO: also depends on treesitter for context awareness
  ["lukas-reineke/indent-blankline.nvim"] = {
    -- event = "BufRead",
    after = "nvim-treesitter",
    config = function()
      require("plugins.configs.blankline").load_keymaps()
      require("plugins.configs.blankline").setup()
    end,
  },

  -- Utilities
  ["rcarriga/nvim-notify"] = {
    event = "VimEnter",
    config = function()
      require "plugins.configs.notify"
    end,
  },

  -- lsp stuff
  ["williamboman/mason.nvim"] = {
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = function()
      require "plugins.configs.mason"
    end,
  },

  ["neovim/nvim-lspconfig"] = {
    opt = true,
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },

  -- UI looks good, LSP partly working, need to install mason-lspconfig.nvim
  -- LSP seems working fine for lua but somehow broken in typescript
  -- LSP only works in first run MasonInstallAll
  -- Install tabnine-cmp
  -- Current have to setup manually after install each server
  -- Should install mason-lspconfig.nvim and setup auto load language server
  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.luasnip")
    end,
  },

  ["saadparwaiz1/cmp_luasnip"] = {
    after = "LuaSnip",
  },

  ["hrsh7th/cmp-nvim-lua"] = {
    after = "cmp_luasnip",
  },

  ["hrsh7th/cmp-nvim-lsp"] = {
    after = "cmp-nvim-lua",
  },

  ["hrsh7th/cmp-buffer"] = {
    after = "cmp-nvim-lsp",
  },

  ["hrsh7th/cmp-path"] = {
    after = "cmp-buffer",
  },

  ["folke/which-key.nvim"] = {
    after = { "telescope.nvim", "indent-blankline.nvim", "ui", "Comment.nvim", "nvim-cmp"},
    module = "which-key",
    keys = "<leader>",
    config = function()
      require("plugins.configs.which-key").setup()
      require("plugins.configs.which-key").register()
    end,
  },

  -- Speed up deffered plugins
  ["lewis6991/impatient.nvim"] = {},
}

require("plugins.configs.packer").run(plugins)
