local M = {}
local api = vim.api

local merge_tb = vim.tbl_deep_extend

M.load_config = function()
  return {
    ui = require('plugins.configs.nvchad-ui').config,
    plugins = {
      override = {},
      remove = {},
      user = {},
    }
  }
end

M.load_mappings = function(section, mapping_opt)
  -- this is called by nvchad_ui can't delete yet
end


M.load_override = function(default_table, plugin_name)
  local user_table = M.load_config().plugins.override[plugin_name] or {}
  user_table = type(user_table) == "table" and user_table or user_table()
  return merge_tb("force", default_table, user_table) or {}
end

M.set_mappings = function(map_table, base)
  local map = vim.keymap.set
  -- iterate over the first keys for each mode
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        if type(options) == "table" then
          cmd = options[1]
          options[1] = nil
        else
          options = {}
        end
        -- extend the keybinding options with the base provided and set the mapping
        map(mode, keymap, cmd, vim.tbl_deep_extend("force", options, base or {}))
      end
    end
  end
end

M.bufilter = function()
  local bufs = vim.t.bufs or nil

  if not bufs then
    return {}
  end

  for i = #bufs, 1, -1 do
    if not vim.api.nvim_buf_is_valid(bufs[i]) then
      table.remove(bufs, i)
    end
  end

  return bufs
end

M.tabuflineNext = function()
  local bufs = M.bufilter() or {}

  for i, v in ipairs(bufs) do
    if api.nvim_get_current_buf() == v then
      vim.cmd(i == #bufs and "b" .. bufs[1] or "b" .. bufs[i + 1])
      break
    end
  end
end

M.tabuflinePrev = function()
  local bufs = M.bufilter() or {}

  for i, v in ipairs(bufs) do
    if api.nvim_get_current_buf() == v then
      vim.cmd(i == 1 and "b" .. bufs[#bufs] or "b" .. bufs[i - 1])
      break
    end
  end
end

M.is_available = function(plugin) return packer_plugins ~= nil and packer_plugins[plugin] ~= nil end

return M
