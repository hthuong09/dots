local M = {};
M.load_hightlight = function() 
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
  local present, nvimtree = pcall(require, "nvim-tree")

  if not present then
    return
  end

  require("base46").load_highlight "nvimtree"

  local options = {
    filters = {
      dotfiles = false,
      exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
    },
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = { "alpha" },
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    view = {
      adaptive_size = true,
      side = "left",
      width = 25,
      hide_root_folder = true,
    },
    git = {
      enable = false,
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      highlight_git = false,
      highlight_opened_files = "none",

      indent_markers = {
        enable = false,
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
        },

        glyphs = {
          default = "",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
  }

  vim.g.nvimtree_side = options.view.side

  nvimtree.setup(options)
  M.load_hightlight()

end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  maps.n["<leader>e"] = {"<cmd> NvimTreeToggle <CR>", desc = "Toggle tree explorer"}
  require('core.utils').set_mappings(maps)
end

return M
