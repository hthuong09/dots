function module(logger)
	-- yabai
	function yabai(args, fallback)
		hs.task
			.new("/opt/homebrew/bin/yabai", function(exitCode, stdOut, stdErr)
				if exitCode == 1 and fallback then
					fallback()
				end
			end, function()
				return true
			end, args)
			:start()
	end

	function yabai_key(mod, key, cmd, cmd2)
		hs.hotkey.bind(mod, key, function()
			yabai(cmd, function()
				yabai(cmd2)
			end)
		end)
	end

	yabai_key({ "cmd", "option" }, "j", { "-m", "window", "--focus", "south" }, { "-m", "display", "--focus", "south" })
	yabai_key({ "cmd", "option" }, "k", { "-m", "window", "--focus", "north" }, { "-m", "display", "--focus", "north" })
	yabai_key({ "cmd", "option" }, "h", { "-m", "window", "--focus", "west" }, { "-m", "display", "--focus", "west" })
	yabai_key({ "cmd", "option" }, "l", { "-m", "window", "--focus", "east" }, { "-m", "display", "--focus", "east" })

	yabai_key({ "cmd", "shift" }, "h", { "-m", "window", "--swap", "west" })
	yabai_key({ "cmd", "shift" }, "l", { "-m", "window", "--swap", "east" })
	yabai_key({ "cmd", "shift" }, "k", { "-m", "window", "--swap", "north" })
	yabai_key({ "cmd", "shift" }, "j", { "-m", "window", "--swap", "south" })

	yabai_key({ "cmd", "control" }, "h", { "-m", "window", "--insert", "west" })
	yabai_key({ "cmd", "control" }, "l", { "-m", "window", "--insert", "east" })
	yabai_key({ "cmd", "control" }, "k", { "-m", "window", "--insert", "north" })
	yabai_key({ "cmd", "control" }, "j", { "-m", "window", "--insert", "south" })

	yabai_key({ "shift", "control" }, "f", { "-m", "window", "--toggle", "float" })
	yabai_key({ "shift", "control" }, "m", { "-m", "window", "--minimize" })
	yabai_key({ "cmd", "shift", "control" }, "f", { "-m", "window", "--toggle", "zoom-fullscreen" })

	-- move window to left half of screen
	yabai_key({ "option", "shift" }, "left", { "-m", "window", "--grid", "1:2:0:0:1:1" })
	-- move window to right half of screen
	yabai_key({ "option", "shift" }, "right", { "-m", "window", "--grid", "1:2:1:0:1:1" })
	-- move window to top half of screen
	yabai_key({ "option", "shift" }, "up", { "-m", "window", "--grid", "2:1:0:0:1:1" })
	-- move window to bottom half of screen
	yabai_key({ "option", "shift" }, "down", { "-m", "window", "--grid", "2:1:0:1:1:1" })

	-- stack
	yabai_key({ "cmd", "control" }, "s", { "-m", "window", "--insert", "stack" })
	-- yabai_key({ "shift", "control" }, "j", { "-m", "window", "--focus", "stack.prev" })
	-- yabai_key({ "shift", "control" }, "k", { "-m", "window", "--focus", "stack.next" })

	hs.hotkey.bind({ "cmd", "shift", "control", "option" }, "b", function()
		yabai({ "-m", "space", "--layout", "bsp" })
		hs.alert.show("Tiling Mode Enabled")
	end)

	hs.hotkey.bind({ "cmd", "shift", "control", "option" }, "f", function()
		yabai({ "-m", "space", "--layout", "float" })
		hs.alert.show("Float Mode Enabled")
	end)

	hs.hotkey.bind({ "option" }, "t", function()
		yabai({ "-m", "window", "--toggle", "float" })
		yabai({ "-m", "window", "--grid", "4:4:1:1:2:2" })
	end)

	-- space control
	local function getSpacesList()
		local spaces_list = {}
		local layout = hs.spaces.allSpaces()
		for _, screen in ipairs(hs.screen.allScreens()) do
			for _, space in ipairs(layout[screen:getUUID()]) do
				table.insert(spaces_list, space)
			end
		end
		return spaces_list
	end

	local function switchToSpace(index)
		local space = getSpacesList()[index]
		if not space then
			return
		end
		hs.spaces.gotoSpace(space)
	end

	local function moveWindowToSpace(index)
		local focused_window = hs.window.focusedWindow()
		if not focused_window then
			return
		end

		local space = getSpacesList()[index]
		if not space then
			return
		end

		if hs.spaces.spaceType(space) ~= "user" then
			return
		end

		local screen = hs.screen.find(hs.spaces.spaceDisplay(space))
		if not screen then
			return
		end

		hs.spaces.moveWindowToSpace(focused_window, space)
		hs.spaces.gotoSpace(space)
	end

	for i = 0, 9, 1 do
		hs.hotkey.bind({ "cmd" }, tostring(i), function()
			switchToSpace(i)
		end)
		hs.hotkey.bind({ "cmd", "shift" }, tostring(i), function()
			moveWindowToSpace(i)
		end)
	end

	logger:i("[TilingWindow] module loaded")
end

return module
