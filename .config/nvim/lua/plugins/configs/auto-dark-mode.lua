local M = {}

function M.config()
	local loaded, auto_dark_mode = pcall(require, "auto-dark-mode")
	if not loaded then
		return
	end
	auto_dark_mode.setup({
		update_interval = 1000,
		set_dark_mode = function()
			require("plugins.configs.base46").toggle_mode("dark")
		end,
		set_light_mode = function()
			require("plugins.configs.base46").toggle_mode("light")
		end,
	})
	auto_dark_mode.init()
end

return M
