astronvim.lsp = {}
local tbl_contains = vim.tbl_contains
local conditional_func = function(func, condition, ...)
  if (condition == nil and true or condition) and type(func) == "function" then
    return func(...)
  end
end
local user_registration = nil
local skip_setup = {}

astronvim.lsp.setup = function(server)
  if not tbl_contains(skip_setup, server) then
    local opts = astronvim.lsp.server_settings(server)
    if type(user_registration) == "function" then
      user_registration(server, opts)
    else
      require("lspconfig")[server].setup(opts)
    end
  end
end

astronvim.lsp.on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  require("core.utils").set_mappings({
    n = {
      ["K"] = {
        function()
          vim.lsp.buf.hover()
        end,
        desc = "Hover symbol details",
      },
      ["<leader>la"] = {
        function()
          vim.lsp.buf.code_action()
        end,
        desc = "LSP code action",
      },
      ["<leader>lf"] = {
        function()
          vim.lsp.buf.formatting_sync()
        end,
        desc = "Format code",
      },
      ["<leader>lh"] = {
        function()
          vim.lsp.buf.signature_help()
        end,
        desc = "Signature help",
      },
      ["<leader>lr"] = {
        function()
          vim.lsp.buf.rename()
        end,
        desc = "Rename current symbol",
      },
      ["gD"] = {
        function()
          vim.lsp.buf.declaration()
        end,
        desc = "Declaration of current symbol",
      },
      ["gI"] = {
        function()
          vim.lsp.buf.implementation()
        end,
        desc = "Implementation of current symbol",
      },
      ["gd"] = {
        function()
          vim.lsp.buf.definition()
        end,
        desc = "Show the definition of current symbol",
      },
      ["gr"] = {
        function()
          vim.lsp.buf.references()
        end,
        desc = "References of current symbol",
      },
      ["<leader>ld"] = {
        function()
          vim.diagnostic.open_float()
        end,
        desc = "Hover diagnostics",
      },
      ["[d"] = {
        function()
          vim.diagnostic.goto_prev()
        end,
        desc = "Previous diagnostic",
      },
      ["]d"] = {
        function()
          vim.diagnostic.goto_next()
        end,
        desc = "Next diagnostic",
      },
      ["gl"] = {
        function()
          vim.diagnostic.open_float()
        end,
        desc = "Hover diagnostics",
      },
    },
  }, { buffer = bufnr })

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
    vim.lsp.buf.formatting()
  end, { desc = "Format file with LSP" })

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      pattern = "<buffer>",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      pattern = "<buffer>",
      callback = vim.lsp.buf.clear_references,
    })
  end

  local on_attach_override = nil
  local aerial_avail, aerial = pcall(require, "aerial")
  conditional_func(on_attach_override, true, client, bufnr)
  conditional_func(aerial.on_attach, aerial_avail, client, bufnr)
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "Auto format before save",
      pattern = "<buffer>",
      callback = vim.lsp.buf.formatting_sync,
    })
  end
end

astronvim.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
astronvim.lsp.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
astronvim.lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.preselectSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
astronvim.lsp.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
astronvim.lsp.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
astronvim.lsp.capabilities = astronvim.lsp.capabilities
astronvim.lsp.flags = {}

function astronvim.lsp.server_settings(server_name)
  local server = require("lspconfig")[server_name]
  -- this does not include config from ./server-settings/* yet
  local opts = {
    capabilities = vim.tbl_deep_extend("force", astronvim.lsp.capabilities, server.capabilities or {}),
    flags = vim.tbl_deep_extend("force", astronvim.lsp.flags, server.flags or {}),
  }
  local status_ok, user_opts = pcall(require, "plugins.configs.lsp.server-settings." .. server_name)
  if status_ok then
    opts = vim.tbl_deep_extend("force", opts, user_opts)
  end
  local old_on_attach = server.on_attach
  local user_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    conditional_func(old_on_attach, true, client, bufnr)
    astronvim.lsp.on_attach(client, bufnr)
    conditional_func(user_on_attach, true, client, bufnr)
  end
  return opts
end

function astronvim.lsp.disable_formatting(client)
  client.resolved_capabilities.document_formatting = false
end

return astronvim.lsp
