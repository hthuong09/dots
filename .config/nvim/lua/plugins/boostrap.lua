local M = {}

function M.int(plugins)
	local ensure_packer = function()
		local fn = vim.fn
		local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
			vim.cmd([[packadd packer.nvim]])
			return true
		end
		return false
	end

	local packer_bootstrap = ensure_packer()

	local final_plugins = {}
	for key, _ in pairs(plugins) do
		plugins[key][1] = key
		final_plugins[#final_plugins + 1] = plugins[key]
	end
	-- require("packer").init({
	-- 	snapshot = "default",
	-- 	snapshot_path = vim.fn.stdpath("config") .. "/packer_snapshots/",
	-- })
	return require("packer").startup(function(use)
		use("wbthomason/packer.nvim")

		for _, v in pairs(final_plugins) do
			use(v)
		end

		if packer_bootstrap then
			require("packer").sync()
		end
	end)
end

return M
