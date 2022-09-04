local M = {}

M.setup = function()
  local present, nvchad_ui = pcall(require, "nvchad_ui")
  if present then
    nvchad_ui.setup()
  end
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  maps.n["<TAB>"] = { function() require("core.utils").tabuflineNext() end, desc = "Goto next buffer" }
  maps.n["<S-Tab>"] = { function() require("core.utils").tabuflinePrev() end, desc = "Goto prev buffer" }
  maps.n["<S-Tab>"] = { function() require("core.utils").tabuflinePrev() end, desc = "Goto prev buffer" }

  require('core.utils').set_mappings(maps)
end

M.config = {
  hl_add = {},
  hl_override = {},
  changed_themes = {},
  theme_toggle = { "onedark", "one_light" },
  theme = "tomorrow_night",
  transparency = false,
}

return M
