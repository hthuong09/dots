local wezterm = require("wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local workspaces = {
	kube = {
		setup = function(window)
			local pane = window:active_pane()
			pane:send_text("k9s\r")

			-- Create a second empty tab
			local tab2 = window:spawn_tab({})
			tab2:activate()
			pane:send_text("clear")
		end,
	},
}

workspace_switcher.get_choices = function(opts)
	if opts == nil then
		opts = { extra_args = "" }
	end
	local choices = {}

	choices, opts.workspace_ids = workspace_switcher.choices.get_workspace_elements(choices)
	choices = workspace_switcher.choices.get_zoxide_elements(choices, opts)

	-- Loop through workspaces and add them if they don't exist in choices
	for workspace_key, _ in pairs(workspaces) do
		local exists = false
		for _, choice in ipairs(choices) do
			if choice.id == workspace_key then
				exists = true
				break
			end
		end
		if not exists then
			table.insert(choices, {
				id = workspace_key,
				label = workspace_key,
			})
		end
	end

	return choices
end

local M = {}
M.switch_workspace = workspace_switcher.switch_workspace
M.switch_active_workspace = function()
	return wezterm.action_callback(function(window, pane)
		wezterm.emit("smart_workspace_switcher.workspace_switcher.start", window, pane)
		local choices = {}

		choices, _ = workspace_switcher.choices.get_workspace_elements(choices)

		window:perform_action(
			wezterm.action.InputSelector({
				action = wezterm.action_callback(function(_, _, id, label)
					if id and label then
						window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = id,
							}),
							pane
						)
					end
				end),
				title = "Choose Active Workspace",
				description = "Select a workspace and press Enter = accept, Esc = cancel, / = filter",
				fuzzy_description = "Workspace to switch: ",
				choices = choices,
				fuzzy = true,
			}),
			pane
		)
	end)
end

M.setup = function()
	-- Listen for workspace switcher creation event
	wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label_path)
		if not window then
			return
		end

		-- Check if the path corresponds to any workspace
		for workspace_name, workspace_config in pairs(workspaces) do
			if path ~= workspace_name then
				break
			end

			if workspace_config.setup then
				wezterm.log_error("setting up workspace: " .. workspace_name)
				workspace_config.setup(window)
				break -- Exit after setting up the matching workspace
			end
		end
	end)
end

return M
