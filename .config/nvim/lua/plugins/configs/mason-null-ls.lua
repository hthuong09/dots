local M = {}

function M.config()
	local status_ok, mason_null_ls = pcall(require, "mason-null-ls")
	if not status_ok then
		return
	end
	mason_null_ls.setup({
		ensure_installed = {
			"stylua",
			"eslint",
			"cspell",
		},
		handlers = {
			function(source)
				-- try to load null-ls
				local null_ls_avail, null_ls = pcall(require, "null-ls")
				if null_ls_avail then
					if null_ls.is_registered(source) then
						return
					end
					for _, type in ipairs({ "diagnostics", "formatting", "code_actions", "completion", "hover" }) do
						if source == "cspell" then
							local config_file = vim.fn.expand("~/.cspell.json")
							-- check if config_file exits
							if vim.fn.filereadable(config_file) == 0 then
								local cspell_json = {
									version = "0.2",
									language = "en",
									words = {},
									flagWords = {},
								}
								local cspell_json_str = vim.json.encode(cspell_json)
								vim.fn.writefile({ cspell_json_str }, config_file)
							end

							null_ls.register(null_ls.builtins.diagnostics.cspell.with({
								extra_args = { "--config", config_file },
								diagnostics_postprocess = function(diagnostic)
									diagnostic.severity = vim.diagnostic.severity.HINT
								end,
								condition = function()
									return vim.fn.executable("cspell") > 0
								end,
							}))
							null_ls.register(null_ls.builtins.code_actions.cspell.with({
								config = {
									find_json = function(cwd)
										return config_file
									end,
								},
							}))
							return
						end

						local builtin = require("null-ls.builtins._meta." .. type)
						if builtin[source] then
							null_ls.register(null_ls.builtins[type][source])
						end
					end
				end
			end,
		},
	})
end

return M
