local M = {}

function M.startup(wezterm, mux)
	local challenge_tab, build_pane, window = mux.spawn_window({
		workspace = "challenge",
		cwd = wezterm.home_dir .. "/xxx/BE/challenge",
		args = { "nvim" },
	})
	challenge_tab:set_title("challenge")

	local tab2, pane2, window2 = window:spawn_tab({
		cwd = wezterm.home_dir .. "/xxx/BE/challenge-BE/challenge-service",
		args = { "nvim" },
	})
	wezterm.log_warn(tab2)
	tab2.set_title("challenge-service")

	local tab3, pane3, window3 = window:spawn_tab({
		cwd = wezterm.home_dir .. "/xxx/BE/challenge-BE/challenge-worker",
		args = { "nvim" },
	})
	tab3.set_title("challenge-worker")

	mux.set_active_workspace("challenge")
end

return M
