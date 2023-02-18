local M = {}

function M.config()
	local present, bufferline = pcall(require, "bufferline")
	if not present then
		return
	end

	bufferline.setup({})
end

return M
