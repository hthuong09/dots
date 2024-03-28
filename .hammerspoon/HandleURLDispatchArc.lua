function module(logger)
	local workSpaceIndex = "1"
	local personalSpaceIndex = "2"

	hs.loadSpoon("URLDispatcher")

	local openLinkWithArcSpace = function(url, spaceIndex)
		local script = [[
			tell application "Arc"
				set focusedSpace to ""
				tell front window
					set focusedSpace to title of active space
					tell space ]] .. spaceIndex .. [[ to focus 
				end tell
				make new tab with properties {URL:"]] .. url .. [["}
				tell front window
					tell space focusedSpace to focus
				end tell
			end tell
		]]
		hs.osascript.applescript(script)
	end

	local openLinkWithArc = function(url)
		local script = [[
			tell application "Arc"
				make new tab with properties {URL:"]] .. url .. [["}
			end tell
		]]
		hs.osascript.applescript(script)
	end

	local sendToSpace = function(t)
		local fn = function(url)
			openLinkWithArcSpace(url, t[2])
		end
		return { t[1], nil, fn }
	end

	spoon.URLDispatcher.url_patterns = {
		sendToSpace({ "https?://shopadmin%.atlassian%.net", workSpaceIndex }),
		sendToSpace({ ".*amplitude%.com", workSpaceIndex }),
		sendToSpace({ "https?://github%.com/shopback/", workSpaceIndex }),
		sendToSpace({ "https?://gitlab%.com/shopback/", workSpaceIndex }),
		sendToSpace({ "https?://device%.sso%.ap%-southeast%-1%.amazonaws%.com/", workSpaceIndex }),
		sendToSpace({ "https?://shopback%.openvpn%.com/", workSpaceIndex }),
		{
			".*",
			nil,
			function(url, senderPID)
				local triggerApp = hs.application.applicationForPID(senderPID)
				if triggerApp then
					if triggerApp:name() == "Slack" then
						openLinkWithArcSpace(url, workSpaceIndex)
						return
					end
					if triggerApp:name() == "zoom.us" then
						openLinkWithArcSpace(url, workSpaceIndex)
						return
					end
					if triggerApp:name() == "Raycast" and url:find("https://meet.google.com", 1, true) == 1 then
						openLinkWithArcSpace(url, workSpaceIndex)
						return
					end
				end
				-- Fallback to browser if no specific rule
				openLinkWithArc(url)
			end,
		},
	}

	spoon.URLDispatcher:start()

	logger:i("[HandleUrlDispatch] module loaded")
end

return module
