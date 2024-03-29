local M = {}

function M.config()
	local loaded, gitsigns = pcall(require, "gitsigns")
	if not loaded then
		return
	end

	local options = {
		signs = {
			add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
			change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
			delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
			topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
			changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
		},
		current_line_blame = true,
	}
	gitsigns.setup(options)
end

return M
