local wezterm = require("wezterm")
local darkTheme = require("themes.base16-tomorrow-night")
local lightTheme = require("themes.ayu-light")

local tab_max_width = 20

local function get_theme(appearance)
	if appearance:find("Dark") then
		return darkTheme
	else
		return lightTheme
	end
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local theme = get_theme(wezterm.gui.get_appearance())
	local tab_bar = theme.tab_bar
	local is_last_tab = tab.tab_index + 1 == #tabs

	local function create_tab_components(fg_color, bg_color, symbol)
		return {
			{ Text = " " },
			{ Text = wezterm.truncate_right(tab.tab_index + 1 .. " ╱ " .. tab.active_pane.title, tab_max_width - 3) },
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
		{ family = "Symbols Nerd Font Mono", scale = 0.7 },
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

		{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
		{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },
		{ key = "6", mods = "ALT", action = wezterm.action.ActivateTab(5) },
		{ key = "7", mods = "ALT", action = wezterm.action.ActivateTab(6) },
		{ key = "8", mods = "ALT", action = wezterm.action.ActivateTab(7) },
		{ key = "9", mods = "ALT", action = wezterm.action.ActivateTab(8) },

		{ key = "X", mods = "CTRL|ALT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

		{
			key = "s",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "v",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "E",
			mods = "CTRL",
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
			opacity = 0.05,
			attachment = "Fixed",
			repeat_x = "NoRepeat",
			repeat_y = "NoRepeat",
			vertical_align = "Bottom",
			horizontal_align = "Left",
			height = 1200,
			width = 849,
		},
	},
	mouse_bindings = {
		{
			event = { Down = { streak = 3, button = "Left" } },
			action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
			mods = "NONE",
		},
	},
}
