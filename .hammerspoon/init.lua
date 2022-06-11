local logger = hs.logger.new('local')

local function getSpacesList()
    local spaces_list = {}
    local layout = hs.spaces.allSpaces()
    for _, screen in ipairs(hs.screen.allScreens()) do
        for _, space in ipairs(layout[screen:getUUID()]) do
            table.insert(spaces_list, space)
        end
    end
    return spaces_list
end

function yabai(args, fallback)
  hs.task.new("/opt/homebrew/bin/yabai", function(exitCode, stdOut, stdErr)
    if (exitCode == 1 and fallback) then
      fallback()
    end
  end, function()
    return true
  end, args):start()
end

function yabai_key(mod, key, cmd, cmd2)
  hs.hotkey.bind(mod, key, function()
    yabai(cmd, function()
      yabai(cmd2)
    end)
  end)
end

yabai_key("cmd", "j", { "-m", "window", "--focus", "south" })
yabai_key("cmd", "k", { "-m", "window", "--focus", "north" })
yabai_key("cmd", "h", { "-m", "window", "--focus", "west" })
yabai_key("cmd", "l", { "-m", "window", "--focus", "east" })

yabai_key({"cmd", "shift"}, "h", { "-m", "window", "--swap", "west" })
yabai_key({"cmd", "shift"}, "l", { "-m", "window", "--swap", "east" })
yabai_key({"cmd", "shift"}, "k", { "-m", "window", "--swap", "north" })
yabai_key({"cmd", "shift"}, "j", { "-m", "window", "--swap", "south" })

hs.hotkey.bind({"cmd", "shift", "control"}, "b", function() 
    yabai({ "-m", "space", "--layout", "bsp" })
    hs.alert.show("Tiling Mode Enabled")
  end)

hs.hotkey.bind({"cmd", "shift", "control"}, "f", function() 
    yabai({ "-m", "space", "--layout", "float" })
    hs.alert.show("Float Mode Enabled")
  end)


local function switchToSpace(index)
    local space = getSpacesList()[index]
    if not space then
        return
    end
    hs.spaces.gotoSpace(space)
end

local function moveWindowToSpace(index)
  local focused_window = hs.window.focusedWindow()
  if not focused_window then
      return
  end

  local space = getSpacesList()[index]
  if not space then
      return
  end

  if hs.spaces.spaceType(space) ~= "user" then
      return
  end

  local screen = hs.screen.find(hs.spaces.spaceDisplay(space))
  if not screen then
      return
  end

  hs.spaces.moveWindowToSpace(focused_window, space)
  hs.spaces.gotoSpace(space)
end

for i = 0,9,1 
do 

  hs.hotkey.bind({"cmd"}, tostring(i), function()
      switchToSpace(i)
  end)
  hs.hotkey.bind({"cmd", "shift"}, tostring(i), function()
      moveWindowToSpace(i)
  end)
end

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
hs.alert.show("Config loaded")
