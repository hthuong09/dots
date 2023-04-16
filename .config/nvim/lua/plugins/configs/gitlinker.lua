local M = {}

function M.config()
	-- check if load gitlinker successfully
	local status_ok, gitlinker = pcall(require, "gitlinker")

	if not status_ok then
		return
	end
	gitlinker.setup()
end

return M
