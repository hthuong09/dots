local wezterm = require("wezterm")
local utils = require("./utils")

local M = {}
M.tab_max_width = 25
M.tab_workspace_max_width = 25

-- inspired from: https://github.com/michaelbrusegard/tabline.wez/blob/main/plugin/tabline/components/tab/process.lua
local process_icons = {
	["bacon"] = wezterm.nerdfonts.dev_rust,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["bat"] = wezterm.nerdfonts.md_bat,
	["bun"] = "",
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["cmd.exe"] = wezterm.nerdfonts.md_console_line,
	["curl"] = wezterm.nerdfonts.md_flattr,
	["default"] = wezterm.nerdfonts.md_application,
	["docker"] = wezterm.nerdfonts.md_docker,
	["docker-compose"] = wezterm.nerdfonts.md_docker,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.dev_git,
	["go"] = wezterm.nerdfonts.md_language_go,
	["htop"] = wezterm.nerdfonts.md_chart_areaspline,
	["kubectl"] = wezterm.nerdfonts.md_kubernetes,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["nix"] = wezterm.nerdfonts.linux_nixos,
	["node"] = wezterm.nerdfonts.md_nodejs,
	["npm"] = wezterm.nerdfonts.md_npm,
	["nvim"] = wezterm.nerdfonts.custom_neovim,
	["pnpm"] = wezterm.nerdfonts.md_npm,
	["rust"] = wezterm.nerdfonts.dev_rust,
	["ssh"] = wezterm.nerdfonts.md_ssh,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["tls"] = wezterm.nerdfonts.md_power_socket,
	["wget"] = wezterm.nerdfonts.md_arrow_down_box,
	["yarn"] = wezterm.nerdfonts.seti_yarn,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["k9s"] = wezterm.nerdfonts.md_kubernetes,
}

M.setup = function()
	wezterm.on("update-right-status", function(window, pane)
		local theme = utils.get_theme()
		local tab_bar = theme.tab_bar
		local workspace = window:active_workspace()

		-- Make it italic and underlined
		window:set_right_status(wezterm.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Background = { Color = tab_bar.active_tab.bg_color } },
			{ Foreground = { Color = tab_bar.active_tab.fg_color } },
			{ Text = " " .. wezterm.nerdfonts.cod_terminal_tmux .. " ╱ " },
			{ Text = #workspace <= M.tab_workspace_max_width and workspace or workspace:match("([^/\\]+)$") },
			{ Text = " " },
		}))
	end)

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local theme = utils.get_theme()
		local tab_bar = theme.tab_bar
		local is_last_tab = tab.tab_index + 1 == #tabs

		local function tab_title(tab_info)
			local title = tab_info.tab_title
			if title and #title > 0 then
				return title
			end

			if tab_info.is_active then
				return tab.active_pane.title
			end

			local process = tab_info.active_pane.foreground_process_name:match("([^/\\]+)$")
			-- in case of multiplexer or ssh, there is no process name
			if not process then
				return tab.active_pane.title
			end
			local icon = process_icons[process] or process_icons.default
			return icon .. " " .. process
		end

		local function tab_zoomed_icon(tab_info)
			if not tab_info.is_active then
				return ""
			end

			for _, pane in ipairs(tab_info.panes) do
				if pane.is_zoomed then
					return " " .. wezterm.nerdfonts.oct_zoom_in
				end
			end

			return ""
		end

		local function create_tab_components(fg_color, bg_color, symbol)
			local zoomed_icon = tab_zoomed_icon(tab)
			local truncate_size = M.tab_max_width - (#zoomed_icon > 0 and 5 or 3)
			return {
				{ Text = " " },
				{
					Text = wezterm.truncate_right(tab.tab_index + 1 .. " ╱ " .. tab_title(tab), truncate_size),
				},
				{ Text = zoomed_icon },
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
end

return M
