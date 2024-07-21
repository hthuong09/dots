function module(logger)
	hs.hotkey.alertDuration = 0
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

	function yabai_key(mod, key, cmd, cmd2, desc)
		hs.hotkey.bind(mod, key, desc, function()
			yabai(cmd, function()
				yabai(cmd2)
			end)
		end)
	end

	yabai_key(
		{ "cmd", "shift" },
		"j",
		{ "-m", "window", "--focus", "south" },
		{ "-m", "display", "--focus", "south" },
		"Focus south"
	)
	yabai_key(
		{ "cmd", "shift" },
		"k",
		{ "-m", "window", "--focus", "north" },
		{ "-m", "display", "--focus", "north" },
		"Focus north"
	)
	yabai_key(
		{ "cmd", "shift" },
		"h",
		{ "-m", "window", "--focus", "west" },
		{ "-m", "display", "--focus", "west" },
		"Focus west"
	)
	yabai_key(
		{ "cmd", "shift" },
		"l",
		{ "-m", "window", "--focus", "east" },
		{ "-m", "display", "--focus", "east" },
		"Focus east"
	)

	yabai_key({ "cmd", "shift", "control" }, "h", { "-m", "window", "--swap", "west" }, nil, "Swap west")
	yabai_key({ "cmd", "shift", "control" }, "l", { "-m", "window", "--swap", "east" }, nil, "Swap east")
	yabai_key({ "cmd", "shift", "control" }, "k", { "-m", "window", "--swap", "north" }, nil, "Swap north")
	yabai_key({ "cmd", "shift", "control" }, "j", { "-m", "window", "--swap", "south" }, nil, "Swap south")

	yabai_key({ "cmd", "control" }, "h", { "-m", "window", "--insert", "west" }, nil, "Insert west")
	yabai_key({ "cmd", "control" }, "l", { "-m", "window", "--insert", "east" }, nil, "Insert east")
	yabai_key({ "cmd", "control" }, "k", { "-m", "window", "--insert", "north" }, nil, "Insert north")
	yabai_key({ "cmd", "control" }, "j", { "-m", "window", "--insert", "south" }, nil, "Insert south")

	yabai_key({ "shift", "control" }, "m", { "-m", "window", "--minimize" }, nil, "Minimize")

	-- move window to left half of screen
	yabai_key(
		{ "option", "shift", "command", "ctrl" },
		"left",
		{ "-m", "window", "--grid", "1:2:0:0:1:1" },
		nil,
		"move window to left half screen"
	)
	-- move window to right half of screen
	yabai_key(
		{ "option", "shift", "command", "ctrl" },
		"right",
		{ "-m", "window", "--grid", "1:2:1:0:1:1" },
		nil,
		"move window to right half screen"
	)
	-- move window to top half of screen
	yabai_key(
		{ "option", "shift", "command", "ctrl" },
		"up",
		{ "-m", "window", "--grid", "2:1:0:0:1:1" },
		nil,
		"move window to top half screen"
	)
	-- move window to bottom half of screen
	yabai_key(
		{ "option", "shift", "command", "ctrl" },
		"down",
		{ "-m", "window", "--grid", "2:1:0:1:1:1" },
		nil,
		"move window to bottom half of screen"
	)

	-- stack
	yabai_key(
		{ "cmd", "control" },
		"p",
		{ "-m", "window", "--focus", "stack.prev" },
		{ "-m", "window", "--focus", "stack.last" },
		"Focus previous stack window"
	)
	yabai_key(
		{ "cmd", "control" },
		"n",
		{ "-m", "window", "--focus", "stack.next" },
		{ "-m", "window", "--focus", "stack.first" },
		"Focus next stack window"
	)

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

	-- no longer working since macos 14.5
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

	for i = 1, 9, 1 do
		-- hs.hotkey.bind({ "alt" }, tostring(i), "Switch to space " .. tostring(i), function()
		-- 	switchToSpace(i)
		-- end)
		hs.hotkey.bind({ "alt", "shift" }, tostring(i), "Move window to space " .. tostring(i), function()
			yabai({ "-m", "window", "--space", tostring(index) })
			hs.eventtap.keyStroke({ "alt" }, tostring(index))
		end)
	end

	logger:i("[TilingWindow] module loaded")
end

hs.hotkey.bind({ "cmd", "shift", "option" }, "h", "Show active hotkeys", function()
	local t = hs.hotkey.getHotkeys()
	local s = ""
	for i = 2, #t do
		s = s .. t[i].msg .. "\n"
	end
	hs.alert(s:sub(1, -2), {
		strokeWidth = 2,
		strokeColor = { white = 1, alpha = 1 },
		fillColor = { white = 0, alpha = 0.75 },
		textColor = { white = 1, alpha = 1 },
		textFont = ".AppleSystemUIFont",
		textSize = 27,
		radius = 27,
		atScreenEdge = 1,
		fadeInDuration = 0.15,
		fadeOutDuration = 0.15,
		padding = nil,
	})
end, hs.alert.closeAll)

return module
