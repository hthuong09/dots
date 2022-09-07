local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then return end
-- TODO: v2 deprecate nvim-lsp-installer
mason_lspconfig.setup()
mason_lspconfig.setup_handlers(
  { function(server) require('plugins.configs.lsp.handlers').setup(server) end }
)
