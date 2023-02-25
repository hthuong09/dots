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
	})
	mason_null_ls.setup_handlers({
		function(source)
			-- try to load null-ls
			local null_ls_avail, null_ls = pcall(require, "null-ls")
			if null_ls_avail then
				if null_ls.is_registered(source) then
					return
				end
				for _, type in ipairs({ "diagnostics", "formatting", "code_actions", "completion", "hover" }) do
					if source == "cspell" then
						null_ls.register(null_ls.builtins.diagnostics.cspell.with({
							diagnostics_postprocess = function(diagnostic)
								diagnostic.severity = vim.diagnostic.severity["WARN"]
							end,
							condition = function()
								return vim.fn.executable("cspell") > 0
							end,
						}))
						null_ls.register(null_ls.builtins.code_actions.cspell)
						return
					end

					local builtin = require("null-ls.builtins._meta." .. type)
					if builtin[source] then
						null_ls.register(null_ls.builtins[type][source])
					end
				end
			end
		end,
	})
end

return M
