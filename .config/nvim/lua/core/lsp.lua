aivim.lsp = {}
-- local sign_define = vim.fn.sign_define
local conditional_func = function(func, condition, ...)
  if (condition == nil and true or condition) and type(func) == "function" then
    return func(...)
  end
end

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
-- for _, sign in ipairs(signs) do
--   sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
-- end

aivim.lsp.formatting = {
  format_on_save = true,
  organize_import_on_save = true,
  disabled = {
    "sumeko_lua",
    "tsserver",
  },
}

aivim.lsp.format_opts = vim.deepcopy(aivim.lsp.formatting)
aivim.lsp.format_opts.disabled = nil
aivim.lsp.format_opts.filter = function(client)
  local filter = aivim.lsp.formatting.filter
  local disabled = aivim.lsp.formatting.disabled
  -- if client is fully disabled, return false
  if vim.tbl_contains(disabled, client.name) then
    return false
  end
  -- if filter function is defined and client is filtered out, return false
  if type(filter) == "function" and not filter(client) then
    return false
  end
  -- client has passed all checks, enable it for formatting
  return true
end

aivim.lsp.diagnostics = {
  off = {
    underline = false,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
  },
  on = {
    virtual_text = false,
    signs = { active = signs },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focused = false,
      style = "minimal",
      -- workaround to have same border as cmpborder, should split when moving color base46 back to repo
      border = {
        { "╭", "CmpBorder" },
        { "─", "CmpBorder" },
        { "╮", "CmpBorder" },
        { "│", "CmpBorder" },
        { "╯", "CmpBorder" },
        { "─", "CmpBorder" },
        { "╰", "CmpBorder" },
        { "│", "CmpBorder" },
      },
      source = "always",
      scope = "cursor",
      header = "",
      prefix = "",
    },
  },
}

--- Helper function to set up a given server with the Neovim LSP client
-- @param server the name of the server to be setup
aivim.lsp.setup = function(server)
  local opts = aivim.lsp.server_settings(server)
  require("lspconfig")[server].setup(opts)
end

--- The `on_attach` function used by aivim
-- @param client the LSP client details when attaching
-- @param bufnr the number of the buffer that the LSP client is attaching to
aivim.lsp.on_attach = function(client, bufnr)
  local capabilities = client.server_capabilities
  local lsp_mappings = {
    n = {
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
    v = {},
  }

  vim.api.nvim_create_augroup("diagnostic_float", {})
  vim.api.nvim_create_autocmd("CursorHold", {
    group = "diagnostic_float",
    buffer = bufn,
    callback = function()
      vim.diagnostic.open_float()
    end,
  })

  if capabilities.codeActionProvider then
    lsp_mappings.n["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      desc = "LSP code action",
    }
    lsp_mappings.v["<leader>la"] = {
      function()
        vim.lsp.buf.range_code_action()
      end,
      desc = "Range LSP code action",
    }
  end

  if capabilities.declarationProvider then
    lsp_mappings.n["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      desc = "Declaration of current symbol",
    }
  end

  if capabilities.definitionProvider then
    lsp_mappings.n["gd"] = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      desc = "Show the definition of current symbol",
    }
  end

  if capabilities.documentFormattingProvider then
    lsp_mappings.n["<leader>lf"] = {
      function()
        vim.lsp.buf.format(aivim.lsp.format_opts)
      end,
      desc = "Format code",
    }
    lsp_mappings.v["<leader>lf"] = {
      function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
        vim.lsp.buf.range_formatting(aivim.lsp.format_opts)
      end,
      desc = "Range format code",
    }

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
      vim.lsp.buf.format(vim.tbl_deep_extend("force", aivim.lsp.format_opts, { async = true }))
    end, { desc = "Format file with LSP" })

    if aivim.lsp.formatting.format_on_save then
      local augroup_name = "auto_format_" .. bufnr
      vim.api.nvim_create_augroup(augroup_name, { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_name,
        desc = "Auto format before save",
        pattern = "<buffer>",
        callback = function()
          vim.lsp.buf.format(aivim.lsp.format_opts)
        end,
      })
    end
  end

  if capabilities.documentHighlightProvider then
    local highlight_name = vim.fn.printf("lsp_document_highlight_%d", bufnr)
    vim.api.nvim_create_augroup(highlight_name, {})
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = highlight_name,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = highlight_name,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end

  if capabilities.hoverProvider then
    lsp_mappings.n["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      desc = "Hover symbol details",
    }
  end

  if capabilities.implementationProvider then
    lsp_mappings.n["gI"] = {
      function()
        require("telescope.builtin").lsp_implementations()
      end,
      desc = "Implementation of current symbol",
    }
  end

  if capabilities.referencesProvider then
    lsp_mappings.n["gr"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      desc = "References of current symbol",
    }
  end

  if capabilities.renameProvider then
    lsp_mappings.n["<leader>lr"] = {
      function()
        vim.lsp.buf.rename()
      end,
      desc = "Rename current symbol",
    }
  end

  if capabilities.signatureHelpProvider then
    lsp_mappings.n["<leader>lh"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      desc = "Signature help",
    }
  end

  if capabilities.typeDefinitionProvider then
    lsp_mappings.n["gT"] = {
      function()
        require("telescope.builtin").lsp_type_definitions()
      end,
      desc = "Definition of current type",
    }
  end

  require("core.utils").set_mappings(lsp_mappings, { buffer = bufnr })
end

--- The default aivim LSP capabilities
aivim.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
aivim.lsp.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
aivim.lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true
aivim.lsp.capabilities.textDocument.completion.completionItem.preselectSupport = true
aivim.lsp.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
aivim.lsp.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
aivim.lsp.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
aivim.lsp.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
aivim.lsp.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
aivim.lsp.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
aivim.lsp.flags = {}

function aivim.lsp.server_settings(server_name)
  local server = require("lspconfig")[server_name]
  local opts = {
    capabilities = vim.tbl_deep_extend("force", aivim.lsp.capabilities, server.capabilities or {}),
    flags = vim.tbl_deep_extend("force", aivim.lsp.flags, server.flags or {}),
  }
  local status_ok, user_opts = pcall(require, "plugins.configs.lsp.server-settings." .. server_name)
  if status_ok then
    opts = vim.tbl_deep_extend("force", opts, user_opts)
  end
  local old_on_attach = server.on_attach
  local user_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    conditional_func(old_on_attach, true, client, bufnr)
    aivim.lsp.on_attach(client, bufnr)
    conditional_func(user_on_attach, true, client, bufnr)
  end
  return opts
end

return aivim.lsp
