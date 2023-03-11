local M = {}

function M.int(plugins)
	local final_plugins = {}
	for key, _ in pairs(plugins) do
		plugins[key][1] = key
		final_plugins[#final_plugins + 1] = plugins[key]
	end
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup(final_plugins)
end

return M
