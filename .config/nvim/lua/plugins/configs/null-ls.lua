local loaded, null_ls = pcall(require, "null-ls")
if not loaded then
  return
end
local config = {
  on_attach = aivim.lsp.on_attach,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
  },
}

null_ls.setup(config)
