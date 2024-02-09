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
		local ts_utils = require("nvim-treesitter.ts_utils")
		cmp.event:on(
			"confirm_done",
			cmp_autopairs.on_confirm_done({
				custom_check = function()
					local node = ts_utils.get_node_at_cursor()
					if node and node:type() == "jsx_self_closing_element" then
						return false
					end

					return true
				end,
			})
		)
	end
end

return M
