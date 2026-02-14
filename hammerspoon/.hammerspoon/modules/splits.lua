local bindings = require("modules.bindings")
local mods = require("modules.mods")

local splitFirst = nil
local splitTap = nil

local function exitSplitMode()
  hs.alert.closeAll()
  splitFirst = nil
  if splitTap then
    splitTap:stop()
    splitTap = nil
  end
end

local function splitApps(appName1, appName2)
  local screen = hs.screen.mainScreen()
  local frame = screen:frame()
  local halfW = frame.w / 2

  hs.application.launchOrFocus(appName1)
  hs.timer.doAfter(0.05, function()
    local win1 = hs.application.get(appName1):mainWindow()
    if win1 then
      win1:setFrame({x = frame.x, y = frame.y, w = halfW, h = frame.h})
    end
  end)

  hs.application.launchOrFocus(appName2)
  hs.timer.doAfter(0.05, function()
    local win2 = hs.application.get(appName2):mainWindow()
    if win2 then
      win2:setFrame({x = frame.x + halfW, y = frame.y, w = halfW, h = frame.h})
    end
  end)
end

local function persistentAlert(message)
  local win = hs.window.focusedWindow()
  return hs.alert.show(message, hs.alert.defaultStyle, win:screen(), true)
end

local function enterSplitMode()
  splitFirst = nil

  persistentAlert("Split: press two app keys (Esc to cancel)")

  splitTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
    local key = hs.keycodes.map[e:getKeyCode()]:upper()

    if key == "ESCAPE" then
      hs.alert.show("Split: cancelled")
      exitSplitMode()
      return true
    end

    local appName = bindings.apps[key]
    if not appName then return true end

    hs.alert.closeAll()

    if not splitFirst then
      splitFirst = appName
      persistentAlert("Split: pick second app")
    else
      splitApps(splitFirst, appName)
      exitSplitMode()
    end

    return true
  end)

  splitTap:start()
end

hs.hotkey.bind(mods.windows, "I", enterSplitMode)

