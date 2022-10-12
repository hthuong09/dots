local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end
require("base46").load_highlight "lsp"
require "nvchad_ui.lsp"

vim.diagnostic.config(aivim.lsp.diagnostics.on)
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
