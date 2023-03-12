local M = {}

function M.config()
	local loaded, indent_blankline = pcall(require, "indent_blankline")
	if not loaded then
		return
	end

	indent_blankline.setup({
		indentLine_enabled = 1,
		filetype_exclude = {
			"help",
			"terminal",
			"alpha",
			"packer",
			"lspinfo",
			"TelescopePrompt",
			"TelescopeResults",
			"mason",
			"lazy",
			"noice",
		},
		buftype_exclude = { "terminal" },
		show_trailing_blankline_indent = false,
		show_first_indent_level = true,
		-- show_current_context = true,
		-- show_current_context_start = true,
	})
end

return M
