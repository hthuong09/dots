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
  ["stevearc/dressing.nvim"] = {
    event = "VimEnter",
    config = function()
      require "plugins.configs.dressing"
    end,
  },

  ["NvChad/extensions"] = { module = { "telescope", "nvchad" } },

  -- UI
  -- TODO: migrate bufferbar and status bar to bufferline and feline
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

  ["lewis6991/gitsigns.nvim"] = {
    event = "BufEnter",
    config = function()
      require "plugins.configs.gitsigns"
    end,
  },

  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
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
      require("plugins.configs.comment").setup()
    end,
    setup = function()
      require("plugins.configs.comment").load_keymaps()
    end,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    event = { "BufRead", "BufNewFile" },
    config = function()
      require "plugins.configs.null-ls"
    end,
  },

  -- Package Manager
  ["williamboman/mason.nvim"] = {
    config = function()
      require "plugins.configs.mason"
    end,
  },
  ["WhoIsSethDaniel/mason-tool-installer.nvim"] = {
    after = "mason.nvim",
    config = function()
      require "plugins.configs.mason-tool-installer"
    end,
  },

  -- Built-in LSP
  ["neovim/nvim-lspconfig"] = {},

  -- LSP manager
  ["williamboman/mason-lspconfig.nvim"] = {
    after = { "mason.nvim", "nvim-lspconfig", "ui" },
    config = function()
      require "plugins.configs.lsp"
    end,
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

  -- load luasnips + cmp related in insert mode only
  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },

  ["tzachar/cmp-tabnine"] = {
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    after = "cmp-path",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine.setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
        show_prediction_strength = false,
      }
    end,
  },

  -- TODO: replace this with neotree.vim
  -- ["kyazdani42/nvim-tree.lua"] = {
  --   ft = "alpha",
  --   cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  --   config = function()
  --     require("plugins.configs.nvimtree").setup()
  --   end,
  --   setup = function()
  --     require("plugins.configs.nvimtree").load_keymaps()
  --   end,
  -- },

  ["nvim-neo-tree/neo-tree.nvim"] = {
    branch = "v2.x",
    module = "neo-tree",
    cmd = "Neotree",
    requires = { { "MunifTanjim/nui.nvim", module = "nui" } },
    setup = function()
      vim.g.neo_tree_remove_legacy_commands = true
      require("plugins.configs.neotree").load_keymaps()
    end,
    config = function()
      require("plugins.configs.neotree").setup()
    end,
  },

  -- Trouble with cmp source, can't setup all at once, probaly move to astronvim add cmp source
  -- Clean up lsp config files
  -- Handle issue whereby the cmp-tabnine does not have function {} warp
  -- install ls null for formatter
  -- setup popup for creatig file etc
  -- support load custom server settings
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
      require "plugins.configs.luasnip"
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
    after = { "telescope.nvim", "indent-blankline.nvim", "ui", "Comment.nvim", "nvim-cmp", "neo-tree.nvim" },
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
