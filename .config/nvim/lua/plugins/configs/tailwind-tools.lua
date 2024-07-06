local M = {}

function M.config()
	local loaded, tailwind_tools = pcall(require, "tailwind-tools")
	if not loaded then
		return
	end

	local config = {}

	tailwind_tools.setup(config)
end

return M
