function module(logger)
    local function isDarkMode()
        local cmd = "defaults read -g AppleInterfaceStyle"
        -- execute cmd and check exit code if it equal 0
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()
        result = result:gsub("^%s*(.-)%s*$", "%1")
        return result
    end

    local current_theme = ""
    local function watchDarkMode()
        local darkMode = isDarkMode()
        local theme = ""
        if darkMode == "Dark" then
            theme = "Base16-tomorrow-night-256"
        else
            theme = "Ayu-light"
        end

        if theme ~= current_theme then
            local cmd = "/opt/homebrew/bin/kitty +kitten themes --reload-in=all " .. theme
            os.execute(cmd)
            current_theme = theme
            logger:i("kitty theme changed to " .. current_theme)
        end

    end

    hs.timer.doEvery(1, watchDarkMode)
end

return module
