local M = {}

function M.config()
	local loaded, null_ls = pcall(require, "null-ls")
	if not loaded then
		return
	end
	local config = {
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier,
		},
	}

	null_ls.setup(config)
end

return M
