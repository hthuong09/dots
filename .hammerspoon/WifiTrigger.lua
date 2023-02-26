function module(logger)
	logger:i("[WifiTrigger] module loaded")
	logger:i(hs.inspect.inspect(hs.audiodevice.allOutputDevices()))
	-- using hammerspoon hs.wifi.watcher to watch wifi changes and trigger events
	toPreventGarbageCollection = hs.wifi.watcher
		.new(function()
			officeSSID = "SHOPBACK"
			logger:i("wifi changed")
			local ssid = hs.wifi.currentNetwork()
			-- get current mute state
			local isMuted = hs.audiodevice.findOutputByName("MacBook Pro Speakers"):muted()
			if ssid == officeSSID then
				logger:i("mute the sound")
				if not isMuted then
					hs.audiodevice.findOutputByName("MacBook Pro Speakers"):setMuted(true)
					hs.notify.new({ title = "Hammerspoon", informativeText = "Sound muted" }):send()
				end
			end
			if ssid ~= officeSSID then
				-- unmute the sound
				logger:i("unmute the sound")
				if isMuted then
					hs.audiodevice.findOutputByName("MacBook Pro Speakers"):setMuted(false)
					hs.notify.new({ title = "Hammerspoon", informativeText = "Sound unmuted" }):send()
				end
			end
		end)
		:start()
end

return module
