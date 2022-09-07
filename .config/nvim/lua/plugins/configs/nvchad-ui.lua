local M = {}

M.setup = function()
  local loaded, nvchad_ui = pcall(require, "nvchad_ui")
  if loaded then
    nvchad_ui.setup()
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

M.config = {
  hl_add = {
    AlphaButtonsShortcut = {
      fg = "#61afef",
    },
  },
  hl_override = {
    AlphaButtons = { fg = "#81A1C1" },
    -- Normal = {
    --   bg = "NONE"
    -- }
  },
  changed_themes = {
    -- tomorrow_night = {
    --   base_16 = {
    --     base00 = "#1e222a",
    --   }
    -- }
  },
  theme_toggle = { "onedark", "tomorrow_night" },
  theme = "onedark",
  transparency = false,
}

return M
