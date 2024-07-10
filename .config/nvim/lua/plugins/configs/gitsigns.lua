local M = {}

function M.config()
	local loaded, gitsigns = pcall(require, "gitsigns")
	if not loaded then
		return
	end

	local options = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		current_line_blame = true,
	}
	vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
	vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "GitSignsAddNr" })
	vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
	vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "GitSignsChangeNr" })
	vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "DiffChangeDelete" })
	vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { link = "GitSignsChangeNr" })
	vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
	vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "GitSignsDeleteNr" })
	vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "DiffDelete" })
	vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { link = "GitSignsDeleteNr" })
	gitsigns.setup(options)
end

return M
