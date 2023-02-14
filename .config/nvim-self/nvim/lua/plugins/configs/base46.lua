local present, base64 = pcall(require, 'base46');
if not present then
  return
end

base64.setup {
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

base64.load_highlight "blankline"
base64.load_highlight "lsp"
base64.load_highlight "mason"
base64.load_highlight "treesitter"
