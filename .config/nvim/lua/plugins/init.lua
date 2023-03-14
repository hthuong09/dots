local plugins = {
	-- Core
	["nvim-lua/plenary.nvim"] = {},
	-- UI
	["hthuong09/base46"] = {
		config = function()
			require("plugins.configs.base46").config()
		end,
	},
	["lukas-reineke/indent-blankline.nvim"] = {
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.configs.indent-blankline").config()
		end,
	},
	["numToStr/Comment.nvim"] = {
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("plugins.configs.comment").config()
		end,
	},
	["windwp/nvim-autopairs"] = {
		config = function()
			require("plugins.configs.autopairs").config()
		end,
	},
	["nvim-treesitter/nvim-treesitter"] = {
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ "windwp/nvim-autopairs", lazy = true },
			{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
			{ "lukas-reineke/indent-blankline.nvim", lazy = true },
		},
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		config = function()
			require("plugins.configs.treesitter").config()
		end,
	},
	-- LSP
	["neovim/nvim-lspconfig"] = {
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
	},
	["williamboman/mason.nvim"] = {
		config = function()
			require("plugins.configs.mason").config()
		end,
	},
	["williamboman/mason-lspconfig.nvim"] = {
		lazy = true,
		config = function()
			require("plugins.configs.lsp").config()
		end,
	},
	-- Completion
	["hrsh7th/nvim-cmp"] = {
		event = "InsertEnter",
		config = function()
			require("plugins.configs.cmp").config()
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},

	-- Moving around
	["nvim-telescope/telescope-file-browser.nvim"] = {
		lazy = true,
		config = function()
			require("plugins.configs.telescope-file-browser").config()
		end,
		init = function()
			require("plugins.configs.telescope-file-browser").load_keymaps()
		end,
	},
	["nvim-telescope/telescope-ui-select.nvim"] = {
		lazy = true,
	},
	["nvim-telescope/telescope-fzf-native.nvim"] = {
		lazy = true,
		build = "make",
	},
	["nvim-telescope/telescope.nvim"] = {
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		cmd = "Telescope",
		version = "0.1.x",
		config = function()
			require("plugins.configs.telescope").config()
			require("plugins.configs.telescope").load_keymaps()
		end,
	},
	["folke/which-key.nvim"] = {
		event = "VeryLazy",
		keys = "<leader>",
		config = function()
			require("plugins.configs.which-key").config()
			require("plugins.configs.which-key").register()
		end,
	},
	["lewis6991/gitsigns.nvim"] = {
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.configs.gitsigns").config()
		end,
	},
	["nvim-tree/nvim-web-devicons"] = {
		commit = "d7f598e",
		config = function()
			require("plugins.configs.devicons").config()
		end,
	},
	["akinsho/bufferline.nvim"] = {
		config = function()
			require("plugins.configs.bufferline").config()
		end,
	},
	["famiu/bufdelete.nvim"] = {
		cmd = { "Bdelete", "Bwipeout" },
	},
	["goolord/alpha-nvim"] = {
		event = "VimEnter",
		config = function()
			require("plugins.configs.alpha").config()
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("plugins.configs.null-ls").config()
		end,
	},
	["jayp0521/mason-null-ls.nvim"] = {
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.configs.mason-null-ls").config()
		end,
	},
	["zbirenbaum/copilot.lua"] = {
		cmd = "Copilot",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.configs.copilot").config()
		end,
	},
	["zbirenbaum/copilot-cmp"] = {
		config = function()
			require("plugins.configs.copilot-cmp").config()
		end,
	},
	["folke/noice.nvim"] = {
		event = "VeryLazy",
		config = function()
			require("plugins.configs.noice").config()
		end,
		dependencies = {
			{ "MunifTanjim/nui.nvim", lazy = true },
			-- "rcarriga/nvim-notify",
		},
	},
	["ray-x/lsp_signature.nvim"] = {
		config = function()
			require("plugins.configs.lsp_signature").config()
		end,
	},

	["Darazaki/indent-o-matic"] = {
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.configs.indent-o-matic").config()
		end,
	},
	["f-person/auto-dark-mode.nvim"] = {
		-- after = { "base46" },
		config = function()
			require("plugins.configs.auto-dark-mode").config()
		end,
	},
	["wakatime/vim-wakatime"] = {
		event = "VeryLazy",
	},
	["echasnovski/mini.indentscope"] = {
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
}

require("plugins.boostrap").int(plugins)
