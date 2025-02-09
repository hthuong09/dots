local tabbar = require("./tabbar")
local workspaces = require("./workspaces")
local utils = require("./utils")
local wezterm = require("wezterm")

workspaces.setup()
tabbar.setup()

local config = {
	-- Fonts
	font = wezterm.font_with_fallback({
		{ family = "Fira Code" },
		{ family = "Symbols Nerd Font Mono" },
		{ family = "Symbols Nerd Font" }, -- Fallback for icons that get removed from v3.0.0 nerdfont
	}),
	font_size = 14,
	line_height = 1.35,
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
				family = "Fira Code",
				weight = 500,
				style = "Italic",
			}),
		},
	},

	-- Windows
	window_decorations = "RESIZE",
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

	-- Tabbar
	use_fancy_tab_bar = false,
	tab_max_width = tabbar.tab_max_width,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,
	inactive_pane_hsb = {
		brightness = 0.6,
		saturation = 0.5,
	},

	-- Key bindings
	keys = {
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
		{
			key = "o",
			mods = "CTRL|SHIFT",
			action = workspaces.switch_workspace(),
		},
		{
			key = "o",
			mods = "CTRL|SHIFT|CMD",
			action = workspaces.switch_active_workspace(),
		},
	},
	mouse_bindings = {
		{
			event = { Down = { streak = 3, button = "Left" } },
			action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
			mods = "NONE",
		},
	},

	-- Theming
	colors = utils.get_theme(),
	macos_window_background_blur = 50,
	background = {
		{
			source = {
				Color = utils.get_theme().background,
			},
			-- opacity = 0.989,
			opacity = 0.92,
			height = "100%",
			width = "100%",
		},
		{
			source = {
				File = wezterm.config_dir .. "/backgrounds/background.png",
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
				File = wezterm.config_dir .. "/backgrounds/background2.png",
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

	-- Misc
	max_fps = 120,
	scrollback_lines = 10000,

	-- debug_key_events = true,
	-- multiplexer (server/client) like tmux
	-- unix_domains = {
	-- 	{
	-- 		name = "unix",
	-- 	},
	-- },
	-- This causes `wezterm` to act as though it was started as
	-- `wezterm connect unix` by default, connecting to the unix
	-- domain on startup.
	-- If you prefer to connect manually, leave out this line.
	-- default_gui_startup_args = { "connect", "unix" },
}

return config
