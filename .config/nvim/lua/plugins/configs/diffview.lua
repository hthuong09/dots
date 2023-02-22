local M = {}

function M.config()
	local status_ok, diffview = pcall(require, "diffview")
	if not status_ok then
		return
	end

	diffview.setup({})
end

return M
