function module(logger)
    function reloadConfig(files)
        doReload = false
        for _,file in pairs(files) do
            if file:sub(-4) == ".lua" then
                doReload = true
            end
        end
        if doReload then
            hs.reload()
        end
    end
    myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
    hs.alert.show("Hammerspoon configurations were reloaded")
  
  
    logger:i('[ConfigReload] module loaded')
end

return module
