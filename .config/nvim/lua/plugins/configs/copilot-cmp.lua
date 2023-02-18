local M = {}

function M.config()
	local loaded, copilot_cmp = pcall(require, "copilot_cmp")
	if not loaded then
		return
	end
	copilot_cmp.setup({})
end

return M
