local M = {}

function M.config()
	local loaded, lsp_signature = pcall(require, "lsp_signature")

	if not loaded then
		return
	end

	lsp_signature.setup({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		handler_opts = {
			border = {
				{ "╭", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╮", "CmpBorder" },
				{ "│", "CmpBorder" },
				{ "╯", "CmpBorder" },
				{ "─", "CmpBorder" },
				{ "╰", "CmpBorder" },
				{ "│", "CmpBorder" },
			},
		},
	})
end

return M
