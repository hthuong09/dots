local M = {}

function M.config()
	local loaded, alpha = pcall(require, "alpha")
	if not loaded then
		return
	end

	local function button(sc, txt, keybind)
		local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

		local opts = {
			position = "center",
			text = txt,
			shortcut = sc,
			cursor = 5,
			width = 36,
			align_shortcut = "right",
			hl = "AlphaButtons",
			hl_shortcut = "AlphaButtonsShortcut",
		}

		if keybind then
			opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
		end

		return {
			type = "button",
			val = txt,
			on_press = function()
				local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
				vim.api.nvim_feedkeys(key, "normal", false)
			end,
			opts = opts,
		}
	end

	-- dynamic header padding
	local fn = vim.fn
	local marginTopPercent = 0.3
	local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

	local options = {
		header = {
			type = "text",
			val = {
				"⡿⠋⠄⣀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⠻⣿⣿",
				"⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠹⣿",
				"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠹",
				"⣿⣿⡟⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⢿⣿⣿⣿⣮⠛⣿⣿⣿⣿⣿⣿⡆",
				"⡟⢻⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣣⠄⡀⢬⣭⣻⣷⡌⢿⣿⣿⣿⣿⣿",
				"⠃⣸⡀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠈⣆⢹⣿⣿⣿⡈⢿⣿⣿⣿⣿",
				"⠄⢻⡇⠄⢛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⡆⠹⣿⣆⠸⣆⠙⠛⠛⠃⠘⣿⣿⣿⣿",
				"⠄⠸⣡⠄⡈⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠁⣠⣉⣤⣴⣿⣿⠿⠿⠿⡇⢸⣿⣿⣿",
				"⠄⡄⢿⣆⠰⡘⢿⣿⠿⢛⣉⣥⣴⣶⣿⣿⣿⣿⣻⠟⣉⣤⣶⣶⣾⣿⡄⣿⡿⢸",
				"⠄⢰⠸⣿⠄⢳⣠⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⡇⢻⡇⢸",
				"⢷⡈⢣⣡⣶⠿⠟⠛⠓⣚⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⠇⠘",
				"⡀⣌⠄⠻⣧⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠛⢿⣿⣿⣿⣿⣿⡟⠘⠄⠄",
				"⣷⡘⣷⡀⠘⣿⣿⣿⣿⣿⣿⣿⣿⡋⢀⣠⣤⣶⣶⣾⡆⣿⣿⣿⠟⠁⠄⠄⠄⠄",
				"⣿⣷⡘⣿⡀⢻⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣿⣿⣿⣿⣷⡿⠟⠉⠄⠄⠄⠄⡄⢀",
				"⣿⣿⣷⡈⢷⡀⠙⠛⠻⠿⠿⠿⠿⠿⠷⠾⠿⠟⣛⣋⣥⣶⣄⠄⢀⣄⠹⣦⢹⣿",
			},
			opts = {
				position = "center",
				hl = "AlphaHeader",
			},
		},
		buttons = {
			type = "group",
			val = {
				button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
				button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
				button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
				button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
			},
			opts = {
				spacing = 1,
			},
		},
		headerPaddingTop = { type = "padding", val = headerPadding },
		headerPaddingBottom = { type = "padding", val = 2 },
		footer = {
			type = "text",
			val = require("alpha.fortune")(),
			opts = {
				position = "center",
				hl = "AlphaButtons",
			},
		},
	}

	alpha.setup({
		layout = {
			options.headerPaddingTop,
			options.header,
			options.headerPaddingBottom,
			options.buttons,
			options.footer,
		},
		opts = {},
	})

	local group_name = vim.api.nvim_create_augroup("alpha_settings", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		desc = "Disable status and tablines for alpha",
		group = group_name,
		pattern = "AlphaReady",
		callback = function()
			local prev_showtabline = vim.opt.showtabline
			local prev_status = vim.opt.laststatus
			vim.opt.laststatus = 0
			vim.opt.showtabline = 0
			vim.opt_local.winbar = nil
			vim.api.nvim_create_autocmd("BufUnload", {
				pattern = "<buffer>",
				callback = function()
					vim.opt.laststatus = prev_status
					vim.opt.showtabline = prev_showtabline
				end,
			})
		end,
	})
end

return M
