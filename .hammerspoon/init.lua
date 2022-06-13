local logger = hs.logger.new('local')
logger.level = 3

require('HandleURLDispatch')(logger)
require('TilingWindow')(logger)
require('ConfigReload')(logger)
