local plugins = {
	-- Core
	["lewis6991/impatient.nvim"] = {},
	["nvim-lua/plenary.nvim"] = {
		module = "plenary",
	},
	-- UI
	["hthuong09/base46"] = {
		config = function()
			require("plugins.configs.base46")
		end,
	},
	["lukas-reineke/indent-blankline.nvim"] = {
		config = function()
			require("plugins.configs.indent-blankline")
		end,
	},
	["JoosepAlviste/nvim-ts-context-commentstring"] = {},
	["numToStr/Comment.nvim"] = {
		after = { "nvim-ts-context-commentstring" },
		config = function()
			require("plugins.configs.comment")
		end,
	},
	["windwp/nvim-autopairs"] = {
		after = { "nvim-cmp" },
		config = function()
			require("plugins.configs.autopairs")
		end,
	},
	["nvim-treesitter/nvim-treesitter"] = {
		requires = {
			{ "windwp/nvim-autopairs", opt = true },
			{ "JoosepAlviste/nvim-ts-context-commentstring", opt = true },
			{ "lukas-reineke/indent-blankline.nvim", opt = true },
		},
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("plugins.configs.treesitter")
		end,
	},
	-- LSP
	["williamboman/mason.nvim"] = {
		config = function()
			require("plugins.configs.mason")
		end,
	},
	["neovim/nvim-lspconfig"] = {},
	["williamboman/mason-lspconfig.nvim"] = {
		after = { "mason.nvim", "nvim-lspconfig" },
		config = function()
			require("plugins.configs.lsp")
		end,
	},
	-- Completion
	["hrsh7th/cmp-nvim-lsp"] = {},
	["hrsh7th/cmp-buffer"] = {},
	["hrsh7th/cmp-path"] = {},
	["L3MON4D3/LuaSnip"] = {},
	["saadparwaiz1/cmp_luasnip"] = {},
	["hrsh7th/nvim-cmp"] = {
		after = { "base46" },
		config = function()
			require("plugins.configs.cmp")
		end,
	},
	-- Moving around
	["nvim-telescope/telescope.nvim"] = {
		tag = "0.1.x",
		config = function()
			require("plugins.configs.telescope").config()
			require("plugins.configs.telescope").load_keymaps()
		end,
	},
	["folke/which-key.nvim"] = {
		module = "which-key",
		event = "VimEnter",
		keys = "<leader>",
		config = function()
			require("plugins.configs.which-key").setup()
			require("plugins.configs.which-key").register()
		end,
	},
	["lewis6991/gitsigns.nvim"] = {
		event = "BufEnter",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	},
	["nvim-tree/nvim-web-devicons"] = {
		commit = "d7f598e",
		config = function()
			require("plugins.configs.devicons")
		end,
	},
	["akinsho/bufferline.nvim"] = {
		config = function()
			require("plugins.configs.bufferline")
		end,
	},
	["famiu/bufdelete.nvim"] = {},
	["goolord/alpha-nvim"] = {
		config = function()
			require("plugins.configs.alpha")
		end,
	},
	["nvim-telescope/telescope-file-browser.nvim"] = {
		config = function()
			require("plugins.configs.telescope-file-browser").setup()
		end,
		setup = function()
			require("plugins.configs.telescope-file-browser").load_keymaps()
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("plugins.configs.null-ls")
		end,
	},
	["jayp0521/mason-null-ls.nvim"] = {
		after = { "mason.nvim", "null-ls.nvim" },
		config = function()
			require("plugins.configs.mason-null-ls")
		end,
	},
}

require("plugins.boostrap").int(plugins)
