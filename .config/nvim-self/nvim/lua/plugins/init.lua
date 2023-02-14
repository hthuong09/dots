local plugins = {
  -- core
  ["lewis6991/impatient.nvim"] = {},
  ["nvim-lua/plenary.nvim"] = {
    module = "plenary",
  },
  -- ui
  ["hthuong09/base46"] = {
    config = function()
      require('plugins.configs.base46')
    end
  },
  -- bar
  ["nvim-lualine/lualine.nvim"] = {
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    config = function()
      require("indent_blankline").setup {
        indentLine_enabled = 1,
        filetype_exclude = {
          "help",
          "terminal",
          "alpha",
          "packer",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "",
        },
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = true,
        -- show_current_context = true,
        -- show_current_context_start = true,
      }
    end
  },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {},
  ["numToStr/Comment.nvim"] = {
    module = { "Comment", "Comment.api" },
    after = { "nvim-ts-context-commentstring" },
    config = function()
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    setup = function()
      vim.keymap.set(
        'n',
        '<leader>/',
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        { desc = "Comment line" }
      )
      vim.keymap.set(
        'v',
        '<leader>/',
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        { desc = "Comment block" }
      )
    end
  },
  ["windwp/nvim-autopairs"] = {
    module = { "nvim-autopairs.completion.cmp" },
    config = function()
      require("nvim-autopairs").setup {}
    end,
    setup = function()
      local cmp_loaded, cmp = pcall(require, "cmp")
      if cmp_loaded then
        cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done { map_char = { tex = "" } })
      end
    end
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    requires = {
      { 'windwp/nvim-autopairs',                       opt = true },
      { 'JoosepAlviste/nvim-ts-context-commentstring', opt = true },
      { "lukas-reineke/indent-blankline.nvim",         opt = true }
    },
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require 'nvim-treesitter.configs'.setup({
        ensure_installed = { "javascript", "typescript", "lua", "html", "vim" },
        sync_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        }, -- JoosepAlviste/nvim-ts-context-commentstring
        autopairs = { enable = true }, -- windwp/nvim-autopairs
        incremental_selection = { enable = true },
        indent = { enable = true } -- lukas-reineke/indent-blankline.nvim
        -- autotag = { enable = true }, -- windwp/nvim-ts-autotag
        -- rainbow = {
        --   enable = true,
        --   disable = { "html" },
        --   extended_mode = false,
        --   max_file_lines = nil,
        -- }, -- p00f/nvim-ts-rainbow
      })
    end
  },
  -- LSP
  ["williamboman/mason.nvim"] = {
    config = function()
      local options = {
        ui = {
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ﮊ",
          },
          keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
          },
        },
        max_concurrent_installers = 10,
      }
      require('mason').setup(options)
    end
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "LspDiagnosticsDefaultError" })
      vim.fn.sign_define("DiagnosticSignWarning", { text = "", texthl = "LspDiagnosticsDefaultWarning" })
      vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "LspDiagnosticsDefaultInformation" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "LspDiagnosticsDefaultHint" })

      vim.diagnostic.config {
        virtual_text = {
          prefix = "",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
      }

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
        focusable = false,
        relative = "cursor",
      })
      -- Borders for LspInfo winodw
      require('lspconfig.ui.windows').default_options.border = 'single'
    end
  },
  ["williamboman/mason-lspconfig.nvim"] = {
    after = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require('plugins.configs.lsp')
    end,
  },
  ["hrsh7th/nvim-cmp"] = {
    config = function()
      require "plugins.configs.cmp"
    end,
  },
  ["L3MON4D3/LuaSnip"] = {},
  ["saadparwaiz1/cmp_luasnip"] = {
    after = "LuaSnip",
  },
}

require("plugins.boostrap").int(plugins)
