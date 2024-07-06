local M = {}

function M.is_mac()
	return vim.loop.os_uname().sysname == "Darwin"
end

function M.set_mappings(map_table, defaultOptions)
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
				map(mode, keymap, cmd, vim.tbl_deep_extend("force", options, defaultOptions or {}))
			end
		end
	end
end

function M.is_available(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

M.border_settings = {
	{ "╭", "CmpBorder" },
	{ "─", "CmpBorder" },
	{ "╮", "CmpBorder" },
	{ "│", "CmpBorder" },
	{ "╯", "CmpBorder" },
	{ "─", "CmpBorder" },
	{ "╰", "CmpBorder" },
	{ "│", "CmpBorder" },
}

return M
