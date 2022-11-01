return {
  on_attach = function(client, bufnr)
    if aivim.lsp.formatting == true then
      local augroup_name = "organize_import_" .. bufnr
      vim.api.nvim_create_augroup(augroup_name, { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_name,
        desc = "Organize import on save",
        pattern = "<buffer>",
        callback = function()
          local param = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(bufnr) },
          }

          vim.lsp.buf.execute_command(param)
        end,
      })
    end
  end,
}
