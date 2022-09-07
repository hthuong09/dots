local M = {}

M.options = {
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    working_sym = "ﲊ",
    error_sym = "✗ ",
    done_sym = " ",
    removed_sym = " ",
    moved_sym = "",
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
}

M.run = function(plugins)
  local loaded, packer = pcall(require, "packer")
  if not loaded then
    return
  end

  local final_plugins = {}
  for key, _ in pairs(plugins) do
    plugins[key][1] = key
    final_plugins[#final_plugins + 1] = plugins[key]
  end

  packer.init(M.options)

  packer.startup(function(use)
    for _, v in pairs(final_plugins) do
      use(v)
    end
  end)
end

return M
