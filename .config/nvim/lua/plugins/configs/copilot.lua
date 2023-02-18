local M = {}

function M.config()
	local loaded, copilot = pcall(require, "copilot")
	if not loaded then
		return
	end
	copilot.setup({
		suggestion = { enabled = false },
		panel = { enabled = false },
	})
end

return M
