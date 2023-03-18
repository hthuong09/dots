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
	wezterm.log_warn(theme)
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

return {
	font = wezterm.font({ family = "Fira Code" }),
	font_size = 13.5,
	line_height = 1.3,
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

	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 0,
	},

	colors = get_theme(wezterm.gui.get_appearance()),

	use_fancy_tab_bar = false,

	tab_max_width = tab_max_width,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,

	inactive_pane_hsb = {
		brightness = 0.8,
		saturation = 0.6,
	},
	window_background_opacity = 0.989,
}
