local M = {}

M.load_highlight = function()
  -- TODO: this is not working
  local colors = require("base46").get_theme_tb "base_30"

  local highlights = {
    NeoTreeDirectoryName = { fg = colors.folder_bg },
    -- NvimTreeEndOfBuffer = { fg = colors.darker_black },
    NeoTreeDirectoryIcon = { fg = colors.folder_bg },
    NvimTreeGitDirty = { fg = colors.red },
    NeoTreeIndentMarker = { fg = colors.grey_fg },
    NeoTreeNormal = { bg = colors.darker_black },
    NeoTreeNormalNC = { bg = colors.darker_black },
    NeoTreeGitIgnored = { fg = colors.light_grey },

    NeoTreeWinSeparator = {
      fg = colors.darker_black,
      bg = colors.darker_black,
    },

    NeoTreeCursorLine = {
      bg = colors.black2,
    },

    NeoTreeGitAdded = {
      fg = colors.yellow,
    },

    NeoTreeGitDeleted = {
      fg = colors.red,
    },

    NeoTreeDotfile = {
      fg = colors.yellow,
      bold = true,
    },
  }
  for hl, col in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl, col)
  end
end

M.setup = function()
  local loaded, neotree = pcall(require, "neo-tree")
  if not loaded then
    return
  end

  neotree.setup {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_diagnostics = false,
    default_component_configs = {
      indent = {
        padding = 0,
        with_expanders = false,
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
      },
      git_status = {
        symbols = {
          added = "",
          deleted = "",
          modified = "",
          renamed = "➜",
          untracked = "★",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        },
      },
    },
    window = {
      width = 25,
      mappings = {
        ["o"] = "open",
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = true,
        hide_gitignored = false,
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
          "__pycache__",
        },
      },
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    git_status = {
      window = {
        position = "float",
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function(_)
          vim.opt_local.signcolumn = "auto"
        end,
      },
    },
  }
  M.load_highlight()
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  maps.n["<leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
  maps.n["<leader>o"] = { "<cmd>Neotree focus<cr>", desc = "Focus Explorer" }
  require("core.utils").set_mappings(maps)
end

return M
