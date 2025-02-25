local M = {}

function M.config()
	local present1, cmp = pcall(require, "cmp")
	local present2, luasnip = pcall(require, "luasnip")
	if not (present1 and present2) then
		return
	end

	local function has_words_before()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	local function border(hl_name)
		return {
			{ "╭", hl_name },
			{ "─", hl_name },
			{ "╮", hl_name },
			{ "│", hl_name },
			{ "╯", hl_name },
			{ "─", hl_name },
			{ "╰", hl_name },
			{ "│", hl_name },
		}
	end

	local cmp_window = require("cmp.utils.window")

	cmp_window.info_ = cmp_window.info
	cmp_window.info = function(self)
		local info = self:info_()
		info.scrollable = false
		return info
	end

	local options = {
		completion = {
			-- auto select first item
			completeopt = "menu,menuone,noinsert",
		},
		window = {
			completion = {
				border = border("CmpBorder"),
				winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
			},
			documentation = {
				border = border("CmpDocBorder"),
				winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
			},
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		formatting = {
			format = function(entry, vim_item)
				local icons = {
					Namespace = "",
					Text = " ",
					Method = " ",
					Function = " ",
					Constructor = " ",
					Field = "ﰠ ",
					Variable = " ",
					Class = "ﴯ ",
					Interface = " ",
					Module = " ",
					Property = "ﰠ ",
					Unit = "塞 ",
					Value = " ",
					Enum = " ",
					Keyword = " ",
					Snippet = " ",
					Color = " ",
					File = " ",
					Reference = " ",
					Folder = " ",
					EnumMember = " ",
					Constant = " ",
					Struct = "פּ ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
					Table = "",
					Object = " ",
					Tag = "",
					Array = "[]",
					Boolean = " ",
					Number = " ",
					Null = "ﳠ",
					String = " ",
					Calendar = "",
					Watch = " ",
					Package = "",
					Copilot = " ",
				}
				local doc = entry.completion_item.documentation
				local utils = require("tailwind-tools.utils")

				if vim_item.kind == "Color" and doc then
					local content = type(doc) == "string" and doc or doc.value
					local base, _, _, _r, _g, _b = 10, content:find("rgba?%((%d+), (%d+), (%d+)")

					if not _r then
						base, _, _, _r, _g, _b = 16, content:find("#(%x%x)(%x%x)(%x%x)")
					end

					if _r then
						local r, g, b = tonumber(_r, base), tonumber(_g, base), tonumber(_b, base)
						vim_item.kind_hl_group = utils.set_hl_from(r, g, b, "foreground")
					end
				end
				vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
				return vim_item
			end,
		},
		mapping = {
			["<Up>"] = cmp.mapping.select_prev_item(),
			["<Down>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		},
		sources = {
			-- { name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "luasnip" },
		},
	}

	cmp.setup(options)
end

return M
