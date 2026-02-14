local dirBindings = {
  H = "toWest",
  J = "toSouth",
  K = "toNorth",
  L = "toEast",
}

local appBindings = {
  C = "Google Chrome",
  B = "Brave",
  T = "iTerm",
  E = "Mail",
  S = "Spotify",
  V = "Surfshark",
  W = "WhatsApp",
  D = "REAPER",
}

local appMods = { "cmd", "ctrl" }
local windowMods = { "cmd", "alt", "ctrl" }

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

  hs.window.animationDuration = 0

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

    local appName = appBindings[key]
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

local function focusApp(appName)
  local app = hs.application.get(appName)

  if app then
    app:activate()
  else
    hs.application.launchOrFocus(appName)
    hs.timer.doAfter(1.5, function()
      app = hs.application.get(appName)
    end)
  end
end

local function moveToScreen(dir)
  local win = hs.window.focusedWindow()
  if not win then return end

  local target = win:screen()[dir](win:screen())
  if not target then return end

  win:moveToScreen(target, false, false)
  win:maximize()
end

local function focusScreen(dir)
  local win = hs.window.focusedWindow()
  if not win then return end

  local target = win:screen()[dir](win:screen())
  if not target then return end
  for _, w in ipairs(hs.window.orderedWindows()) do
    if w:screen() == target then
      w:focus()
      break
    end
  end
end

local function toggleFullscreen()
  local win = hs.window.focusedWindow()
  if win then
    win:toggleFullscreen()
  end
end

local function maximize()
  local win = hs.window.focusedWindow()
  if win then
    win:maximize()
  end
end

local function cycleFocusedApp()
  local app = hs.application.frontmostApplication()
  if not app then return end

  local wins = app:allWindows()
  if #wins < 2 then return end

  table.sort(wins, function(a, b) return a:id() < b:id() end)

  local focused = hs.window.focusedWindow()
  for i, win in ipairs(wins) do
    if win == focused then
      wins[i % #wins + 1]:focus()
      return
    end
  end
end

local function loadAppBindings()
  for key, appName in pairs(appBindings) do
    hs.hotkey.bind(appMods, key, function() focusApp(appName) end)
  end
end

local function loadWindowBindings()
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "F", toggleFullscreen)
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", maximize)
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "I", enterSplitMode)
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "C", cycleFocusedApp)

  for key, dir in pairs(dirBindings) do
    hs.hotkey.bind(windowMods, key, function() moveToScreen(dir) end)
    hs.hotkey.bind(appMods, key, function() focusScreen(dir) end)
  end
end


local function loadBindings()
  loadAppBindings()
  loadWindowBindings()

  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
  end)
end

loadBindings()

hs.alert.show("Hammerspoon loaded")
