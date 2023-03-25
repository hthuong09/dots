local M = {}

function M.config()
	local loaded, telescope = pcall(require, "telescope")
	if not loaded then
		return
	end

	telescope.load_extension("file_browser")
end

function M.load_keymaps()
	local maps = { n = {}, v = {}, t = {}, [""] = {} }
	maps.n["<leader>e"] = {
		"<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ cwd_to_path = true, path = vim.fn.expand('%:p:h'), hidden = true, respect_gitignore = false })<CR>",
		desc = "File Browser",
	}
	require("core.utils").set_mappings(maps)
end

return M
