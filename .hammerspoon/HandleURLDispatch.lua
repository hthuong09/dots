function module(logger)
	local workProfile = "Profile 1"
	local personalProfile = "Profile 2"

	hs.loadSpoon("URLDispatcher")

	local openLinkWithChromePorifle = function(url, profile)
		local t = hs.task.new("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome", nil, function()
			return false
		end, { "--profile-directory=" .. profile, url })
		t:start()
	end

	local sendToProfile = function(t)
		local fn = function(url)
			openLinkWithChromePorifle(url, t[2])
		end
		return { t[1], nil, fn }
	end

	spoon.URLDispatcher.url_patterns = {
		sendToProfile({ "https?://shopadmin%.atlassian%.net", workProfile }),
		sendToProfile({ ".*amplitude%.com", workProfile }),
		sendToProfile({ "https?://github%.com/shopback/", workProfile }),
		sendToProfile({ "https?://gitlab%.com/shopback/", workProfile }),
		sendToProfile({ "https?://device%.sso%.ap%-southeast%-1%.amazonaws%.com/", workProfile }),
		{
			".*",
			nil,
			function(url, senderPID)
				local triggerApp = hs.application.applicationForPID(senderPID)
				if triggerApp then
					if triggerApp:name() == "Slack" then
						openLinkWithChromePorifle(url, workProfile)
						return
					end
				end
				openLinkWithChromePorifle(url, personalProfile)
			end,
		},
		sendToProfile({ ".*", personalProfile }),
	}

	spoon.URLDispatcher:start()

	logger:i("[HandleUrlDispatch] module loaded")
end

return module
