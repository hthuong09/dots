print(hs.location.get())
local logger = hs.logger.new("local")
logger.level = 3
require("ConfigReload")(logger)

-- require("HandleURLDispatch")(logger)
require("HandleURLDispatchArc")(logger)
require("TilingWindow")(logger)
-- require("KittySession")(logger)
require("WifiTrigger")(logger)
-- require("WatchDarkMode")(logger)
require("Keymapping")(logger)
