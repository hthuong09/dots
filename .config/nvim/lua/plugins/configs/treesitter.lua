local M = {}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "javascript", "typescript", "lua", "html", "vim", "tsx" },
		sync_install = false,
		ignore_install = {},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		}, -- JoosepAlviste/nvim-ts-context-commentstring
		autopairs = { enable = true }, -- windwp/nvim-autopairs
		incremental_selection = { enable = true },
		indent = { enable = true }, -- lukas-reineke/indent-blankline.nvim
		autotag = { enable = true }, -- windwp/nvim-ts-autotag
		-- rainbow = {
		--   enable = true,
		--   disable = { "html" },
		--   extended_mode = false,
		--   max_file_lines = nil,
		-- }, -- p00f/nvim-ts-rainbow
	})
end

return M
