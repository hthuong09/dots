local M = {}

function M.startup(wezterm, mux)
	local tab, pane, window = mux.spawn_window({
		workspace = "challenge",
		cwd = wezterm.home_dir .. "/ShopBack/BE/challenge",
	})
	tab:set_title("challenge")
	pane:send_text("nvim\r")

	local tab2, pane2, window2 = window:spawn_tab({
		cwd = wezterm.home_dir .. "/ShopBack/BE/challenge-BE/challenge-service",
	})
	tab2:set_title("challenge-service")
	pane2:send_text("nvim\r")

	local tab3, pane3, window3 = window:spawn_tab({
		cwd = wezterm.home_dir .. "/ShopBack/BE/challenge-BE/challenge-worker",
	})
	tab3:set_title("challenge-worker")
	pane3:send_text("nvim\r")

	tab:activate()

	mux.set_active_workspace("challenge")
end

return M
