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
