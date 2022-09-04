vim.cmd "packadd packer.nvim"

local plugins = {

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
      require('plugins.configs.nvchad-ui').load_keymaps()
    end
  },

  ["kyazdani42/nvim-web-devicons"] = {
    after = "ui",
    module = "nvim-web-devicons",
    config = function()
      require("plugins.configs.devicons")
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    -- cmd = "Telescope",
    config = function()
      require("plugins.configs.telescope").setup();
    end,
    setup = function()
      require("plugins.configs.telescope").load_keymaps();
    end,
  },

  ["folke/which-key.nvim"] = {
    after = { "telescope.nvim" },
    module = "which-key",
    keys = "<leader>",
    config = function()
      require("plugins.configs.which-key").setup();
      require("plugins.configs.which-key").register();
    end,
  },

  -- Speed up deffered plugins
  ["lewis6991/impatient.nvim"] = {},
}

require("plugins.configs.packer").run(plugins)
