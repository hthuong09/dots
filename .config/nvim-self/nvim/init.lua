vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require "core.options"
require "core.mappings"

require "plugins"
