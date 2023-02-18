local M = {}

function M.config()
	local present, wk = pcall(require, "which-key")
	if not present then
		return
	end

	require("base46").load_highlight("whichkey")

	local options = {
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "  ", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "none", -- none/single/double/shadow
		},
		layout = {
			spacing = 6, -- spacing between columns
		},
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			i = { "j", "k" },
			v = { "j", "k" },
		},
	}
	wk.setup(options)
end

function M.register()
	local status_ok, which_key = pcall(require, "which-key")
	if not status_ok then
		return
	end

	local is_available = require("core.utils").is_available
	local mappings = {
		n = {
			["<leader>"] = {
				f = { name = "File" },
				p = { name = "Packer" },
			},
		},
	}

	local extra_sections = {
		g = "Git",
		s = "Search",
		S = "Session",
		t = "Terminal",
		l = "LSP",
	}

	local function init_table(mode, prefix, idx)
		if not mappings[mode][prefix][idx] then
			mappings[mode][prefix][idx] = { name = extra_sections[idx] }
		end
	end

	if is_available("neovim-session-manager") then
		init_table("n", "<leader>", "S")
	end

	if is_available("gitsigns.nvim") then
		init_table("n", "<leader>", "g")
	end

	if is_available("nvim-lspconfig") then
		init_table("n", "<leader>", "l")
	end

	if is_available("nvterm") then
		init_table("n", "<leader>", "g")
		init_table("n", "<leader>", "t")
	end

	if is_available("telescope.nvim") then
		init_table("n", "<leader>", "s")
		init_table("n", "<leader>", "g")
	end

	for mode, prefixes in pairs(mappings) do
		for prefix, mapping_table in pairs(prefixes) do
			which_key.register(mapping_table, {
				mode = mode,
				prefix = prefix,
				buffer = nil,
				silent = true,
				noremap = true,
				nowait = true,
			})
		end
	end
end

return M
