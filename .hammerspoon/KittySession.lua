function module(logger)
	local choices = {}
	table.insert(choices, {
		text = "No session",
	})
	for file in hs.fs.dir("~/.config/kitty/sessions") do
		if file ~= "." and file ~= ".." then
			table.insert(choices, {
				text = file,
				file = "~/.config/kitty/sessions/" .. file,
			})
		end
	end

  function kitty(args, title)
    print(title)
    local window = hs.window.get(title)
    if window then
      window:focus()
      return
    end
    local params = table.concat(args, " ")
    os.execute('/opt/homebrew/bin/kitty ' .. params .. ' --title ' .. title .. ' --instance-group session -1 &')
  end

	local function focusLastFocused()
		local wf = hs.window.filter
		local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
		if #lastFocused > 0 then
			lastFocused[1]:focus()
		end
	end

	local chooser = hs.chooser.new(function(choice)
		if not choice then
			focusLastFocused()
			return
		end
    if choice.file then
      kitty({"-d", "~", "--session", choice.file}, choice.text)
    else
      kitty({"-d", "~"}, 'kitty')
    end
		focusLastFocused()
	end)
	chooser:choices(choices)
  hs.hotkey.bind({"cmd", "ctrl"}, "t", function() chooser:show() end)
	logger:i("[KittySession] module loaded")
end

return module
