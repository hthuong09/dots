local present, base46 = pcall(require, 'base46');
if not present then
  return
end

base46.setup {
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
    tomorrow_night = {
      base_16 = {
        base08 = "#81ac6f",
      },
    },
  },
  theme = "tomorrow_night",
}

base46.load_highlight "blankline"
base46.load_highlight "lsp"
base46.load_highlight "mason"
base46.load_highlight "treesitter"
base46.load_highlight "cmp"
base46.load_highlight "telescope"
base46.load_highlight "devicons"
base46.load_highlight "alpha"
