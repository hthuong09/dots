return {
  on_attach = M.lsp.disable_formatting,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [M.install.home .. "/lua"] = true,
          [M.install.config .. "/lua"] = true,
        },
      },
    },
  },
}
