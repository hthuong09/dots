local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("base46").load_highlight "lsp"
require "nvchad_ui.lsp"

local sign_define = vim.fn.sign_define

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
vim.diagnostic.config {
  virtual_text = true,
  signs = { active = signs },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

require "plugins.configs.lsp.handlers"
require "plugins.configs.mason-lspconfig"

-- enable server that was created without mason
-- for _, server in ipairs(user_plugin_opts "lsp.servers") do
--   astronvim.lsp.setup(server)
-- end
