local M = {}

M.setup = function()
  local loaded, nvchad_ui = pcall(require, "nvchad_ui")
  if loaded then
    nvchad_ui.setup()
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "TabEnter" }, {
      pattern = "*",
      callback = function()
        if #vim.fn.getbufinfo { buflisted = 1 } >= 2 or #vim.api.nvim_list_tabpages() >= 2 then
          vim.opt.showtabline = 2
          vim.opt.tabline = "%!v:lua.require('nvchad_ui').tabufline()"
        end
      end,
    })
  end
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  maps.n["<TAB>"] = {
    function()
      require("core.utils").tabuflineNext()
    end,
    desc = "Goto next buffer",
  }
  maps.n["<S-Tab>"] = {
    function()
      require("core.utils").tabuflinePrev()
    end,
    desc = "Goto prev buffer",
  }
  maps.n["<S-Tab>"] = {
    function()
      require("core.utils").tabuflinePrev()
    end,
    desc = "Goto prev buffer",
  }

  require("core.utils").set_mappings(maps)
end

-- TODO modular this so plugin can happens inside module's configuration
-- TODO consider to add highlight current column HL CursorColumn
-- Refactor so  can load color config here

M.config = {
  hl_add = {
    AlphaButtonsShortcut = {
      fg = "#61afef",
    },
  },
  hl_override = {
    DiffAdd = { fg = "#a4b595" },
    DiffChange = { fg = "#DE935F" },

    AlphaButtons = { fg = "#81A1C1" },
    -- Normal = {
    --   bg = "NONE"
    -- }
    LspReferenceText = { bg = "#3e4451", fg = "NONE" },
    LspReferenceRead = { bg = "#3e4451", fg = "NONE" },
    LspReferenceWrite = { bg = "#3e4451", fg = "NONE" },
  },
  changed_themes = {
    -- tomorrow_night = {
    --   base_16 = {
    --     base00 = "#1e222a",
    --   }
    -- }
    tomorrow_night = {
      base_16 = {
        base08 = "#81ac6f",
      },
    },
  },
  theme_toggle = { "onedark", "tomorrow_night" },
  theme = "tomorrow_night",
  transparency = false,
}

return M
