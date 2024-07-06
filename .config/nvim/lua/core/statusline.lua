-- from https://github.com/hthuong09/nvchad-ui/blob/main/lua/nvchad_ui/statusline/modules.lua
local fn = vim.fn
local version = vim.version().minor
local separators = {
	left = "",
	right = " ",
}
local sep_l = separators["left"]
local sep_r = separators["right"]

local modes = {
	["n"] = { "NORMAL", "St_NormalMode" },
	["niI"] = { "NORMAL i", "St_NormalMode" },
	["niR"] = { "NORMAL r", "St_NormalMode" },
	["niV"] = { "NORMAL v", "St_NormalMode" },
	["no"] = { "N-PENDING", "St_NormalMode" },
	["i"] = { "INSERT", "St_InsertMode" },
	["ic"] = { "INSERT (completion)", "St_InsertMode" },
	["ix"] = { "INSERT completion", "St_InsertMode" },
	["t"] = { "TERMINAL", "St_TerminalMode" },
	["nt"] = { "NTERMINAL", "St_NTerminalMode" },
	["v"] = { "VISUAL", "St_VisualMode" },
	["V"] = { "V-LINE", "St_VisualMode" },
	["Vs"] = { "V-LINE (Ctrl O)", "St_VisualMode" },
	[""] = { "V-BLOCK", "St_VisualMode" },
	["R"] = { "REPLACE", "St_ReplaceMode" },
	["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
	["s"] = { "SELECT", "St_SelectMode" },
	["S"] = { "S-LINE", "St_SelectMode" },
	[""] = { "S-BLOCK", "St_SelectMode" },
	["c"] = { "COMMAND", "St_CommandMode" },
	["cv"] = { "COMMAND", "St_CommandMode" },
	["ce"] = { "COMMAND", "St_CommandMode" },
	["r"] = { "PROMPT", "St_ConfirmMode" },
	["rm"] = { "MORE", "St_ConfirmMode" },
	["r?"] = { "CONFIRM", "St_ConfirmMode" },
	["!"] = { "SHELL", "St_TerminalMode" },
}

local M = {}

M.mode = function()
	local m = vim.api.nvim_get_mode().mode
	local current_mode = "%#" .. modes[m][2] .. "#" .. "  " .. modes[m][1]
	local mode_sep1 = "%#" .. modes[m][2] .. "Sep" .. "#" .. sep_r

	return current_mode .. " " .. mode_sep1 .. "%#ST_EmptySpace#" .. sep_r
end

M.fileInfo = function()
	local icon = "  "
	local filename = (fn.expand("%") == "" and "Empty ") or fn.expand("%:t")

	if filename ~= "Empty " then
		local devicons_present, devicons = pcall(require, "nvim-web-devicons")

		if devicons_present then
			local ft_icon = devicons.get_icon(filename)
			icon = (ft_icon ~= nil and " " .. ft_icon) or ""
		end

		filename = " " .. filename .. " "
	end

	return "%#St_file_info#" .. icon .. filename .. "%#St_file_sep#" .. sep_r
end

M.git = function()
	if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
		return ""
	end

	local git_status = vim.b.gitsigns_status_dict

	local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
	local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
	local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
	local branch_name = "  " .. string.sub(git_status.head, 1, 30) .. (#git_status.head > 30 and "..." or "") .. " "

	return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed
end

M.LSP_Diagnostics = function()
	if not rawget(vim, "lsp") then
		return ""
	end

	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
	local info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

	errors = (errors and errors > 0) and ("%#St_lspError#" .. " " .. errors .. " ") or ""
	warnings = (warnings and warnings > 0) and ("%#St_lspWarning#" .. "  " .. warnings .. " ") or ""
	hints = (hints and hints > 0) and ("%#St_lspHints#" .. "ﯧ " .. hints .. " ") or ""
	info = (info and info > 0) and ("%#St_lspInfo#" .. " " .. info .. " ") or ""

	return errors .. warnings .. hints .. info
end

M.LSP_status = function()
	local lsp = "%#St_LspStatus#" .. "  "
	local client_names = {}
	local function has_value(tab, val)
		for index, value in ipairs(tab) do
			if value == val then
				return true
			end
		end
		return false
	end

	if rawget(vim, "lsp") then
		for _, client in ipairs(vim.lsp.get_clients()) do
			if client.attached_buffers[vim.api.nvim_get_current_buf()] then
				if vim.o.columns <= 100 then
					return "   LSP "
				end
				if client.name == "null-ls" then
					local null_ls = require("null-ls")
					local formatters = null_ls.builtins.formatting
					local linters = null_ls.builtins.diagnostics
					local ft = vim.bo.filetype
					for _, formatter in pairs(formatters) do
						if has_value(formatter.filetypes, ft) then
							table.insert(client_names, formatter.name)
						end
					end
					for _, linter in pairs(linters) do
						if has_value(linter.filetypes, ft) then
							table.insert(client_names, linter.name)
						end
					end
				else
					table.insert(client_names, client.name)
				end
			end
		end
	end
	if client_names ~= "" then
		return lsp .. table.concat(client_names, ", ") .. " "
	end
end

M.cwd = function()
	local dir_icon = "%#St_cwd_icon#" .. " "
	local dir_name = "%#St_cwd_text#" .. " " .. fn.fnamemodify(fn.getcwd(), ":t") .. " "
	return (vim.o.columns > 85 and ("%#St_cwd_sep#" .. sep_l .. dir_icon .. dir_name)) or ""
end

M.cursor_position = function()
	local left_sep = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon#" .. " "

	local current_line = fn.line(".")
	local total_line = fn.line("$")
	local text = math.modf((current_line / total_line) * 100) .. tostring("%%")

	text = (current_line == 1 and "Top") or text
	text = (current_line == total_line and "Bot") or text

	return left_sep .. "%#St_pos_text#" .. " " .. text .. " "
end

M.statusline = function()
	return table.concat({
		M.mode(),
		M.fileInfo(),
		M.git(),

		"%=",
		-- M.LSP_progress(),
		-- "%=",

		M.LSP_Diagnostics(),
		M.LSP_status() or "",
		M.cwd(),
		M.cursor_position(),
	})
end

M.setup = function()
	vim.opt.statusline = "%!v:lua.require('core.statusline').statusline()"
end

return M
