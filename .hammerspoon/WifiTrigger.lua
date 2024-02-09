-- This will mute the sound when connect to unknown wifi
function module(logger)
	logger:i("[WifiTrigger] module loaded")
	logger:i(hs.inspect.inspect(hs.audiodevice.allOutputDevices()))
	local knownWifi = {
		"HOMELAB",
		"HOMELAB_BED",
		"HOMELAB_GPON",
		"Hong Bui House 4.2_5G",
		"Hong Bui House 4.2",
	}
	-- using hammerspoon hs.wifi.watcher to watch wifi changes and trigger events
	ww = hs.wifi.watcher.new(function()
		logger:i("wifi changed")
		local ssid = hs.wifi.currentNetwork()
		logger:i("current wifi: " .. ssid)
		-- get current mute state
		local isMuted = hs.audiodevice.findOutputByName("MacBook Pro Speakers"):muted()
		-- if wifi is not in knownWifi list, mute the sound
		if not hs.fnutils.contains(knownWifi, ssid) then
			logger:i("mute the sound")
			if not isMuted then
				hs.audiodevice.findOutputByName("MacBook Pro Speakers"):setMuted(true)
				hs.notify.new({ title = "Hammerspoon", informativeText = "Sound muted" }):send()
			end
		else
			logger:i("unmute the sound")
			if isMuted then
				hs.audiodevice.findOutputByName("MacBook Pro Speakers"):setMuted(false)
				hs.notify.new({ title = "Hammerspoon", informativeText = "Sound un-muted" }):send()
			end
		end
	end)
	ww:start()
end

return module
