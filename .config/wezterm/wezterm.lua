local wezterm = require("wezterm")
local mux = wezterm.mux
local darkTheme = require("themes.base16-tomorrow-night")
local lightTheme = require("themes.ayu-light")

local tab_max_width = 25

local function get_theme(appearance)
	if appearance:find("Dark") then
		return darkTheme
	else
		return lightTheme
	end
end

local function contains(list, x)
	for _, v in pairs(list) do
		if v == x then
			return true
		end
	end
	return false
end

local function get_file_name(file)
	local file_name = file:match("[^/]*.lua$")
	return file_name:sub(0, #file_name - 4)
end

local function generate_workspace_input_selector()
	local workspace_dir = wezterm.home_dir .. "/.config/wezterm/workspaces"
	local workspace_files = wezterm.glob(workspace_dir .. "/*.lua")
	local choices = {
		{
			label = "default",
		},
	}
	for _, workspace_file in ipairs(workspace_files) do
		local proj_name = get_file_name(workspace_file)
		table.insert(choices, #choices + 1, {
			label = proj_name,
		})
	end

	return {
		action = wezterm.action_callback(function(window, pane, id, workspace_name)
			local all_workspaces = wezterm.mux.get_workspace_names()
			if contains(all_workspaces, workspace_name) then
				mux.set_active_workspace(workspace_name)
				return
			end

			local success, workspace = pcall(require, "workspaces." .. workspace_name)
			if not success then
				wezterm.log_error("Failed to load workspace: " .. workspace_name)
				return
			end

			if type(workspace.startup) ~= "function" then
				wezterm.log_error("Workspace startup is not a function")
				return
			end

			workspace.startup(wezterm, mux)
		end),
		title = "Select Workspaces",
		choices = choices,
	}
end

wezterm.on("gui-startup", function(cmd)
	local args = {}
	if cmd then
		args = cmd.args
	end

	local workspace_name = args[1]

	if not workspace_name then
		return
	end

	local all_workspaces = wezterm.mux.get_workspace_names()
	if contains(all_workspaces, workspace_name) then
		mux.set_active_workspace(workspace_name)
		return
	end

	local success, workspace = pcall(require, "workspaces." .. workspace_name)
	if not success then
		wezterm.log_error("Failed to load workspace: " .. workspace_name)
		return
	end

	if type(workspace.startup) ~= "function" then
		wezterm.log_error("Workspace startup is not a function")
		return
	end

	workspace.startup(wezterm, mux)
end)

local launch_workspace_action = wezterm.action.InputSelector({
	action = wezterm.action_callback(function(window, pane, id, label)
		if not id and not label then
			wezterm.log_info("cancelled")
			return
		else
			wezterm.log_info("you selected ", id, label)
			pane:send_text(id)
			-- TODO: launch workspace here
		end
	end),
	title = "Select Workspace",
	choices = {
		{
			label = "challenge",
			id = "challenge",
		},
	},
})

wezterm.on("update-right-status", function(window, pane)
	local theme = get_theme(wezterm.gui.get_appearance())
	local tab_bar = theme.tab_bar
	local workspace = window:active_workspace()

	-- Make it italic and underlined
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = tab_bar.active_tab.bg_color } },
		{ Foreground = { Color = tab_bar.active_tab.fg_color } },
		{ Text = "   ╱ " },
		{ Text = workspace },
		{ Text = " " },
	}))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local theme = get_theme(wezterm.gui.get_appearance())
	local tab_bar = theme.tab_bar
	local is_last_tab = tab.tab_index + 1 == #tabs

	function tab_title(tab_info)
		local title = tab_info.tab_title
		-- if the tab title is explicitly set, take that
		if title and #title > 0 then
			return title
		end
		-- Otherwise, use the title from the active pane
		-- in that tab
		return tab.active_pane.title
	end

	local function create_tab_components(fg_color, bg_color, symbol)
		return {
			{ Text = " " },
			{ Text = wezterm.truncate_right(tab.tab_index + 1 .. " ╱ " .. tab_title(tab), tab_max_width - 3) },
			{ Text = " " },
			{ Foreground = { Color = fg_color } },
			{ Background = { Color = bg_color } },
			{ Text = symbol },
		}
	end

	if tab.is_active then
		if is_last_tab then
			return create_tab_components(tab_bar.active_tab.bg_color, tab_bar.background, "")
		else
			return create_tab_components(tab_bar.active_tab.bg_color, tab_bar.inactive_tab.bg_color, "")
		end
	end

	local next_tab = tabs[tab.tab_index + 2]
	if next_tab and next_tab.is_active then
		return create_tab_components(tab_bar.inactive_tab.bg_color, tab_bar.active_tab.bg_color, "")
	end

	if is_last_tab then
		return create_tab_components(tab_bar.inactive_tab.bg_color, tab_bar.background, "")
	end

	return create_tab_components(tab_bar.background, tab_bar.inactive_tab.bg_color, "╱")
end)

local theme = get_theme(wezterm.gui.get_appearance())

return {
	font = wezterm.font_with_fallback({
		{ family = "Fira Code" },
		{ family = "Symbols Nerd Font" },
	}),
	font_size = 13.5,
	line_height = 1.25,
	font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "Fira Code",
				weight = "Bold",
			}),
		},
		{
			italic = true,
			font = wezterm.font({
				family = "OperatorMono Nerd Font",
				weight = "Regular",
				style = "Italic",
			}),
		},
	},

	window_decorations = "RESIZE",
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

	scrollback_lines = 10000,

	colors = theme,

	use_fancy_tab_bar = false,

	tab_max_width = tab_max_width,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,

	inactive_pane_hsb = {
		brightness = 0.6,
		saturation = 0.5,
	},

	max_fps = 120,

	keys = {
		-- {
		-- 	key = "P",
		-- 	mods = "CTRL",
		-- 	action = wezterm.action.ActivateCommandPalette, -- need nightly build
		-- },
		{ key = "H", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "L", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "K", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "J", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "z", mods = "CMD", action = wezterm.action.TogglePaneZoomState },

		{ key = "1", mods = "SUPER", action = wezterm.action.ActivateTab(0) },
		{ key = "2", mods = "SUPER", action = wezterm.action.ActivateTab(1) },
		{ key = "3", mods = "SUPER", action = wezterm.action.ActivateTab(2) },
		{ key = "4", mods = "SUPER", action = wezterm.action.ActivateTab(3) },
		{ key = "5", mods = "SUPER", action = wezterm.action.ActivateTab(4) },
		{ key = "6", mods = "SUPER", action = wezterm.action.ActivateTab(5) },
		{ key = "7", mods = "SUPER", action = wezterm.action.ActivateTab(6) },
		{ key = "8", mods = "SUPER", action = wezterm.action.ActivateTab(7) },
		{ key = "9", mods = "SUPER", action = wezterm.action.ActivateTab(8) },

		{ key = "x", mods = "CTRL|ALT|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		{
			key = "s",
			mods = "CTRL|SHIFT|CMD",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "v",
			mods = "CTRL|SHIFT|CMD",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "e",
			mods = "CTRL|SHIFT",
			action = wezterm.action.QuickSelectArgs({
				patterns = {
					"https?://\\S+",
				},
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.open_with(url)
				end),
			}),
		},

		{ key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(-1) },
		{ key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(1) },
		{
			key = "~",
			mods = "CTRL|SHIFT",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 25 },
			}),
		},
		-- {
		-- 	key = "t",
		-- 	mods = "CMD|CTRL",
		-- 	action = launch_workspace_action,
		-- },
		{
			key = "o",
			mods = "CTRL|SHIFT",
			action = wezterm.action.InputSelector(generate_workspace_input_selector()),
		},
	},

	macos_window_background_blur = 50,
	background = {
		{
			source = {
				Color = theme.background,
			},
			-- opacity = 0.989,
			opacity = 0.92,
			height = "100%",
			width = "100%",
		},
		-- {
		-- 	source = {
		-- 		File = wezterm.config_dir .. "/window-logo.png",
		-- 	},
		-- 	opacity = 0.015,
		-- 	attachment = "Fixed",
		-- 	repeat_x = "NoRepeat",
		-- 	repeat_y = "NoRepeat",
		-- 	vertical_align = "Bottom",
		-- 	horizontal_align = "Right",
		-- 	height = 1000,
		-- 	width = 479,
		-- },
		{
			source = {
				File = wezterm.config_dir .. "/background.png",
			},
			opacity = 0.02,
			attachment = "Fixed",
			repeat_x = "NoRepeat",
			repeat_y = "NoRepeat",
			vertical_align = "Bottom",
			horizontal_align = "Left",
			height = 1200,
			width = 849,
		},
		{
			source = {
				File = wezterm.config_dir .. "/background2.png",
			},
			opacity = 0.03,
			attachment = "Fixed",
			repeat_x = "NoRepeat",
			repeat_y = "NoRepeat",
			vertical_align = "Top",
			horizontal_align = "Right",
			height = 1097,
			width = 719,
		},
	},
	mouse_bindings = {
		{
			event = { Down = { streak = 3, button = "Left" } },
			action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
			mods = "NONE",
		},
	},
	debug_key_events = true,
}
