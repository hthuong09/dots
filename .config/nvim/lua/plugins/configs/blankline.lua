local M = {}

M.setup = function()
  local loaded, blankline = pcall(require, "indent_blankline")

  if not loaded then
    return
  end

  require("base46").load_highlight "blankline"

  local options = {
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
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = true,
  }

  blankline.setup(options)
end

M.load_keymaps = function()
  local maps = { n = {}, v = {}, t = {}, [""] = {} }
  maps.n["<leader>cc"] = {
    function()
      local ok, start = require("indent_blankline.utils").get_current_context(
        vim.g.indent_blankline_context_patterns,
        vim.g.indent_blankline_use_treesitter_scope
      )

      if ok then
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
        vim.cmd [[normal! _]]
      end
    end,
    desc = "Jump to current_context",
  }
  require("core.utils").load_mappings(maps)
end

return M
