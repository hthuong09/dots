local M = {}

function M.config()
	local autopair_loaded, autopairs = pcall(require, "nvim-autopairs")
	if not autopair_loaded then
		return
	end
	autopairs.setup({})

	-- Auto add ( when select item on nvim for methods, functions
	local cmp_loaded, cmp = pcall(require, "cmp")
	if cmp_loaded then
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end
end

return M
