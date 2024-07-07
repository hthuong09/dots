local M = {}

function M.config()
	local loaded, tailwind_tools = pcall(require, "tailwind-tools")
	if not loaded then
		return
	end

	local config = {
		conceal = {
			enabled = true, -- can be toggled by commands
			min_length = nil, -- only conceal classes exceeding the provided length
			symbol = "󱏿", -- only a single character is allowed
			highlight = { -- extmark highlight options, see :h 'highlight'
				fg = "#38BDF8",
			},
		},
	}

	tailwind_tools.setup(config)
end

return M
