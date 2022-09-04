local present, devicons = pcall(require, "nvim-web-devicons")

if present then
  require("base46").load_highlight "devicons"
  local options = { override = require("nvchad_ui.icons").devicons }
  devicons.setup(options)
end
