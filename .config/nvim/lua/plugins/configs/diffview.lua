local M = {}

function M.config()
	local status_ok, diffview = pcall(require, "diffview")
	if not status_ok then
		return
	end

	diffview.setup({
		-- enhanced_diff_hl = true,
		hooks = {
			-- diff_buf_read = function()
			--   vim.opt_local.wrap = false
			-- end,
			-- @diagnostic disable-next-line: unused-local
			diff_buf_win_enter = function(bufnr, winid, ctx)
				-- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
				-- the right.
				if ctx.layout_name:match("^diff2") then
					if ctx.symbol == "a" then
						vim.opt_local.winhl = table.concat({
							"DiffChange:DiffviewDiffChangeAsDelete",
							"DiffText:DiffviewDiffTextAsDelete",
							"DiffDelete:DiffviewDiffDelete",
							"DiffAdd:DiffviewDiffAddAsDelete",
						}, ",")
					elseif ctx.symbol == "b" then
						vim.opt_local.winhl = table.concat({
							"DiffChange:DiffviewDiffChangeDiffAdd",
							"DiffText:DiffviewDiffTextAsAdd",
							"DiffAdd:DiffviewDiffAdd",
							"DiffDelete:DiffviewDiffDelete",
						}, ",")
					end
				end
			end,
		},
	})
end

function M.load_keymaps()
	local maps = { n = {}, v = {}, t = {}, [""] = {} }
	maps.n["<leader>gdh"] = {
		"<cmd>DiffviewOpen HEAD<CR>",
		desc = "Open diffview with HEAD",
	}
	maps.n["<leader>gdm"] = {
		"<cmd>DiffviewOpen master<CR>",
		desc = "Open diffview with `master`",
	}
	maps.n["<leader>gdM"] = {
		"<cmd>DiffviewOpen main<CR>",
		desc = "Open diffview with `main`",
	}
	maps.n["<leader>gdc"] = {
		"<cmd>DiffviewClose<CR>",
		desc = "Close diffview",
	}

	require("core.utils").set_mappings(maps)
end

return M
