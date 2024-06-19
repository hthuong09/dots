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

function module(logger)
	logger:i("[Keymapping] module loaded")
	hs.loadSpoon("RecursiveBinder")

	spoon.RecursiveBinder.escapeKey = { {}, "escape" } -- Press escape to abort
	spoon.RecursiveBinder.helperFormat = {
		atScreenEdge = 2,
		strokeColor = { white = 0, alpha = 2 },
		textFont = "Fira Code",
		textSize = 18,
	}
	spoon.RecursiveBinder.helperEntryEachLine = 3

	local singleKey = spoon.RecursiveBinder.singleKey

	local weztermIdentifier = "com.github.wez.wezterm"

	local keyMap = {
		[singleKey("t", "terminal+")] = {
			[singleKey("e", "select link")] = function()
				hs.eventtap.keyStroke({ "ctrl", "shift" }, "e", weztermIdentifier)
			end,
			[singleKey("s", "split")] = function()
				hs.eventtap.keyStroke({ "ctrl", "shift", "command" }, "s", weztermIdentifier)
			end,
			[singleKey("v", "split vertical")] = function()
				hs.eventtap.keyStroke({ "ctrl", "shift", "command" }, "v", weztermIdentifier)
			end,
			[singleKey("t", "split term")] = function()
				hs.eventtap.keyStroke({ "ctrl", "shift" }, "`", weztermIdentifier)
			end,
			[singleKey("c", "close panel")] = function()
				hs.eventtap.keyStroke({ "ctrl", "shift", "alt" }, "x", weztermIdentifier)
			end,
		},
		[singleKey("w", "window+")] = {
			-- focus
			[singleKey("f", "focus+")] = {
				[singleKey("h", "west")] = function()
					yabai({ "-m", "window", "--focus", "west" }, function()
						yabai({ "-m", "display", "--focus", "west" })
					end)
				end,
				[singleKey("j", "south")] = function()
					yabai({ "-m", "window", "--focus", "south" }, function()
						yabai({ "-m", "display", "--focus", "south" })
					end)
				end,
				[singleKey("k", "north")] = function()
					yabai({ "-m", "window", "--focus", "north" }, function()
						yabai({ "-m", "display", "--focus", "north" })
					end)
				end,
				[singleKey("l", "east")] = function()
					yabai({ "-m", "window", "--focus", "east" }, function()
						yabai({ "-m", "display", "--focus", "east" })
					end)
				end,
			},
			-- swap
			[singleKey("s", "swap+")] = {
				[singleKey("h", "west")] = function()
					yabai({ "-m", "window", "--swap", "west" })
				end,
				[singleKey("j", "south")] = function()
					yabai({ "-m", "window", "--swap", "south" })
				end,
				[singleKey("k", "north")] = function()
					yabai({ "-m", "window", "--swap", "north" })
				end,
				[singleKey("l", "east")] = function()
					yabai({ "-m", "window", "--swap", "east" })
				end,
			},
			-- toggle
			[singleKey("t", "toggle+")] = {
				[singleKey("f", "space float")] = function()
					yabai({ "-m", "space", "--layout", "float" })
				end,
				[singleKey("t", "space tiling")] = function()
					yabai({ "-m", "space", "--layout", "bsp" })
				end,
				[singleKey("s", "space stack")] = function()
					yabai({ "-m", "space", "--layout", "stack" })
				end,
			},
		},
	}

	hs.hotkey.bind({ "option", "command", "control", "shift" }, "space", spoon.RecursiveBinder.recursiveBind(keyMap))
end

return module
