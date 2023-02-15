local M = {}

M.config = function()
  local loaded, telescope = pcall(require, "telescope")
  if not loaded then
    return
  end

  -- vim.g.theme_switcher_loaded = true

  local options = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = {
          ["q"] = require("telescope.actions").close,
        },
        i = {
          ["<C-c>"] = require("telescope.actions").close,
        },
      },
    },
    extensions_list = { "themes" },
  }

  -- check for any override
  telescope.setup(options)
  -- load extensions
  pcall(function()
    for _, ext in ipairs(options.extensions_list) do
      telescope.load_extension(ext)
    end
  end)
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {},[""] = {} }
  maps.n["<leader>fw"] = {
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Search words",
  }
  maps.n["<leader>fW"] = {
    function()
      require("telescope.builtin").live_grep {
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
      }
    end,
    desc = "Search words in all files",
  }
  maps.n["<leader>gt"] = {
    function()
      require("telescope.builtin").git_status()
    end,
    desc = "Git status",
  }
  maps.n["<leader>gb"] = {
    function()
      require("telescope.builtin").git_branches()
    end,
    desc = "Git branches",
  }
  maps.n["<leader>gc"] = {
    function()
      require("telescope.builtin").git_commits()
    end,
    desc = "Git commits",
  }
  maps.n["<leader>ff"] = {
    function()
      require("telescope.builtin").find_files()
    end,
    desc = "Search files",
  }
  maps.n["<leader>fF"] = {
    function()
      require("telescope.builtin").find_files { hidden = true, no_ignore = true }
    end,
    desc = "Search all files",
  }
  maps.n["<leader>fb"] = {
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Search buffers",
  }
  maps.n["<leader>fh"] = {
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Search help",
  }
  maps.n["<leader>fm"] = {
    function()
      require("telescope.builtin").marks()
    end,
    desc = "Search marks",
  }
  maps.n["<leader>fo"] = {
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "Search history",
  }
  maps.n["<leader>fc"] = {
    function()
      require("telescope.builtin").grep_string()
    end,
    desc = "Search for word under cursor",
  }
  maps.n["<leader>sb"] = {
    function()
      require("telescope.builtin").git_branches()
    end,
    desc = "Git branches",
  }
  maps.n["<leader>sh"] = {
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Search help",
  }
  maps.n["<leader>sm"] = {
    function()
      require("telescope.builtin").man_pages()
    end,
    desc = "Search man",
  }
  maps.n["<leader>sn"] = {
    function()
      require("telescope").extensions.notify.notify()
    end,
    desc = "Search notifications",
  }
  maps.n["<leader>sr"] = {
    function()
      require("telescope.builtin").registers()
    end,
    desc = "Search registers",
  }
  maps.n["<leader>sk"] = {
    function()
      require("telescope.builtin").keymaps()
    end,
    desc = "Search keymaps",
  }
  maps.n["<leader>sc"] = {
    function()
      require("telescope.builtin").commands()
    end,
    desc = "Search commands",
  }

  require("core.utils").set_mappings(maps)
end

return M
