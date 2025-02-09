local wezterm = require("wezterm")
local darkTheme = require("themes.base16-tomorrow-night")
local lightTheme = require("themes.ayu-light")
local M = {}

M.darkTheme = darkTheme
M.lightTheme = lightTheme

M.get_theme = function()
	-- Temporary disable auto theme as it's malfunctioning when switching workspaces
	return darkTheme
	-- local appearance = wezterm.gui.get_appearance()
	-- if appearance:find("Dark") then
	-- 	return darkTheme
	-- else
	-- 	return lightTheme
	-- end
end

M.contains = function(list, x)
	for _, v in pairs(list) do
		if v == x then
			return true
		end
	end
	return false
end

return M
