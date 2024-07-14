local M = {}

function M.config()
	local present, noice = pcall(require, "noice")
	if not present then
		return
	end

	noice.setup({
		routes = {
			{
				view = "notify",
				filter = { event = "msg_showmode" },
			},
		},
		views = {
			cmdline_input = {
				view = "cmdline_popup",
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = { Normal = "CmpPmenu" },
				},
			},
			cmdline_popup = { -- minimal cmdline_popup
				border = {
					style = "none",
					padding = { 1, 2 },
				},
				filter_options = {},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			hover = {
				focusable = false,
				border = {
					style = "rounded",
					padding = { 0, 0 },
				},
				win_options = {
					winhighlight = { Normal = "CmpPmenu", FloatBorder = "CmpBorder" },
				},
				anchor = "SW",
				position = {
					row = 1,
				},
			},
			custom_signature = {
				view = "hover",
			},
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				enabled = true,
			},
			signature = {
				enabled = false,
				view = "custom_signature",
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	})
end

return M
