local M = {}

function M.config()
	local present, base46 = pcall(require, "base46")
	if not present then
		return
	end

	base46.setup({
		hl_add = {
			DiffviewDiffAdd = {
				bg = "#293732",
				fg = "none",
			},
			DiffviewDiffChangeDiffAdd = {
				link = "DiffviewDiffAdd",
			},
			DiffviewDiffTextAsAdd = {
				bg = "#345d3c",
				fg = "none",
			},

			DiffviewDiffDelete = {
				link = "Comment",
			},
			DiffviewDiffChangeAsDelete = {
				bg = "#372d30",
				fg = "none",
			},
			DiffviewDiffAddAsDelete = {
				link = "DiffviewDiffChangeAsDelete",
			},
			DiffviewDiffTextAsDelete = {
				bg = "#7d3d3c",
				fg = "none",
			},
		},
		hl_override = {
			-- NormalFloat = { bg = "NONE" },

			-- AlphaButtons = { fg = "#81A1C1" },
			Normal = {
				bg = "NONE",
			},
			-- LspReferenceText = { bg = "#3e4451", fg = "NONE" },
			-- LspReferenceRead = { bg = "#3e4451", fg = "NONE" },
			-- LspReferenceWrite = { bg = "#3e4451", fg = "NONE" },
		},
		changed_themes = {
			tomorrow_night = {
				background = "none",
				base_16 = {
					base08 = "#81ac6f",
				},
			},
		},
		theme = "tomorrow_night",
	})

	base46.load_highlight("blankline")
	base46.load_highlight("lsp")
	base46.load_highlight("mason")
	base46.load_highlight("treesitter")
	base46.load_highlight("cmp")
	base46.load_highlight("telescope")
	base46.load_highlight("devicons")
	base46.load_highlight("alpha")
	base46.load_highlight("bufferline")
	base46.load_highlight("notify")
	base46.load_highlight("indentscope")
	base46.load_highlight("git")

	local links = {
		["@lsp.type.namespace"] = "@namespace",
		["@lsp.type.type"] = "@type",
		["@lsp.type.class"] = "@type",
		["@lsp.type.enum"] = "@type",
		["@lsp.type.interface"] = "@type",
		["@lsp.type.struct"] = "@structure",
		["@lsp.type.parameter"] = "@parameter",
		["@lsp.type.variable"] = "@variable",
		["@lsp.type.property"] = "@property",
		["@lsp.type.enumMember"] = "@constant",
		["@lsp.type.function"] = "@function",
		["@lsp.type.method"] = "@method",
		["@lsp.type.macro"] = "@macro",
		["@lsp.type.decorator"] = "@function",
	}
	for newgroup, oldgroup in pairs(links) do
		vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
	end
end

function M.toggle_mode(mode)
	local dark_theme = "tomorrow_night"
	local light_theme = "ayu-light"
	local theme = mode == "light" and light_theme or dark_theme
	if vim.g.base46_theme ~= theme then
		vim.g.base46_theme = theme
		require("base46").load_all_highlights()
	end
end

return M
