local loaded, mason_lspconfig = pcall(require, "mason-lspconfig")
if not loaded then
	return
end

vim.fn.sign_define("DaiagnosticSignError", { text = "", texthl = "LspDiagnosticsDefaultError" })
vim.fn.sign_define("DiagnosticSignWarning", { text = "", texthl = "LspDiagnosticsDefaultWarning" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "LspDiagnosticsDefaultInformation" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "LspDiagnosticsDefaultHint" })

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		focused = false,
		style = "minimal",
		-- workaround to have same border as cmpborder, should split when moving color base46 back to repo
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
		source = "always",
		scope = "cursor",
		header = "",
		prefix = "",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
	focusable = false,
	relative = "cursor",
})

-- Borders for LspInfo winodw
require("lspconfig.ui.windows").default_options.border = "single"

local lsp_opts = {}
lsp_opts.formatting = {
	format_on_save = true,
	organize_import_on_save = true,
	disabled = { "lua_ls", "tsserver" },
}

lsp_opts.format_opts = vim.deepcopy(lsp_opts.formatting)
lsp_opts.format_opts.disabled = nil
lsp_opts.format_opts.filter = function(client)
	local filter = lsp_opts.formatting.filter
	local disabled = lsp_opts.formatting.disabled
	-- if client is fully disabled, return false
	if vim.tbl_contains(disabled, client.name) then
		return false
	end
	-- if filter function is defined and client is filtered out, return false
	if type(filter) == "function" and not filter(client) then
		return false
	end
	-- client has passed all checks, enable it for formatting
	return true
end

mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "rust_analyzer", "tsserver" },
})
mason_lspconfig.setup_handlers({
	function(server)
		local opts = {}
		opts.capabilities = vim.lsp.protocol.make_client_capabilities()
		opts.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
		opts.capabilities.textDocument.completion.completionItem.snippetSupport = true
		opts.capabilities.textDocument.completion.completionItem.preselectSupport = true
		opts.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
		opts.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
		opts.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
		opts.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
		opts.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
		opts.capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "documentation", "detail", "additionalTextEdits" },
		}
		opts.settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/lsp")] = true,
					},
				},
			},
		}
		opts.on_attach = function(client, bufnr)
			local capabilities = client.server_capabilities
			local lsp_mappings = {
				n = {
					["<leader>ld"] = {
						function()
							vim.diagnostic.open_float()
						end,
						desc = "Hover diagnostics",
					},
					["[d"] = {
						function()
							vim.diagnostic.goto_prev()
						end,
						desc = "Previous diagnostic",
					},
					["]d"] = {
						function()
							vim.diagnostic.goto_next()
						end,
						desc = "Next diagnostic",
					},
					["gl"] = {
						function()
							vim.diagnostic.open_float()
						end,
						desc = "Hover diagnostics",
					},
				},
				v = {},
			}

			vim.api.nvim_create_augroup("diagnostic_float", {})
			vim.api.nvim_create_autocmd("CursorHold", {
				group = "diagnostic_float",
				buffer = bufnr,
				callback = function()
					vim.diagnostic.open_float()
				end,
			})

			if capabilities.codeActionProvider then
				lsp_mappings.n["<leader>la"] = {
					function()
						vim.lsp.buf.code_action()
					end,
					desc = "LSP code action",
				}
				lsp_mappings.v["<leader>la"] = {
					function()
						vim.lsp.buf.range_code_action()
					end,
					desc = "Range LSP code action",
				}
			end

			if capabilities.declarationProvider then
				lsp_mappings.n["gD"] = {
					function()
						vim.lsp.buf.declaration()
					end,
					desc = "Declaration of current symbol",
				}
			end

			if capabilities.definitionProvider then
				lsp_mappings.n["gd"] = {
					function()
						require("telescope.builtin").lsp_definitions()
					end,
					desc = "Show the definition of current symbol",
				}
			end

			if capabilities.documentFormattingProvider then
				lsp_mappings.n["<leader>lf"] = {
					function()
						vim.lsp.buf.format(lsp_opts.format_opts)
					end,
					desc = "Format code",
				}
				lsp_mappings.v["<leader>lf"] = {
					function()
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", false)
						vim.lsp.buf.range_formatting(lsp_opts.format_opts)
					end,
					desc = "Range format code",
				}

				vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
					vim.lsp.buf.format(vim.tbl_deep_extend("force", lsp_opts.format_opts, { async = true }))
				end, { desc = "Format file with LSP" })

				if lsp_opts.formatting.format_on_save then
					local augroup_name = "auto_format_" .. bufnr
					vim.api.nvim_create_augroup(augroup_name, { clear = true })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup_name,
						desc = "Auto format before save",
						pattern = "<buffer>",
						callback = function()
							vim.lsp.buf.format(lsp_opts.format_opts)
						end,
					})
				end
			end

			if capabilities.documentHighlightProvider then
				local highlight_name = vim.fn.printf("lsp_document_highlight_%d", bufnr)
				vim.api.nvim_create_augroup(highlight_name, {})
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					group = highlight_name,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.document_highlight()
					end,
				})
				vim.api.nvim_create_autocmd("CursorMoved", {
					group = highlight_name,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.clear_references()
					end,
				})
			end

			if capabilities.hoverProvider then
				lsp_mappings.n["K"] = {
					function()
						vim.lsp.buf.hover()
					end,
					desc = "Hover symbol details",
				}
			end

			if capabilities.implementationProvider then
				lsp_mappings.n["gI"] = {
					function()
						require("telescope.builtin").lsp_implementations()
					end,
					desc = "Implementation of current symbol",
				}
			end

			if capabilities.referencesProvider then
				lsp_mappings.n["gr"] = {
					function()
						require("telescope.builtin").lsp_references()
					end,
					desc = "References of current symbol",
				}
			end

			if capabilities.renameProvider then
				lsp_mappings.n["<leader>lr"] = {
					function()
						vim.lsp.buf.rename()
					end,
					desc = "Rename current symbol",
				}
			end

			if capabilities.signatureHelpProvider then
				lsp_mappings.n["<leader>lh"] = {
					function()
						vim.lsp.buf.signature_help()
					end,
					desc = "Signature help",
				}
			end

			if capabilities.typeDefinitionProvider then
				lsp_mappings.n["gT"] = {
					function()
						require("telescope.builtin").lsp_type_definitions()
					end,
					desc = "Definition of current type",
				}
			end

			require("core.utils").set_mappings(lsp_mappings, { buffer = bufnr })
		end

		require("lspconfig")[server].setup(opts)
	end,
})
