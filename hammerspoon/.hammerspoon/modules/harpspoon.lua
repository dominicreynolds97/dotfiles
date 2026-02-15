local bindings = require("modules.bindings")
local mods = require("modules.mods")

local function getBoundKeys()
  local bound = {}
  for key, _ in pairs(bindings.apps) do
    bound[key:upper()] = true
  end
  return bound
end

local fallbackKeys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

local function getOrAssignKey(appName, bound)
  for key, name in pairs(bindings.apps) do
    if name == appName then return key, false end
  end

  local key = string.sub(appName, 0, 1):upper()
  if not bound[key] and key:match("^[A-Z]$") then
    return key, true
  end

  for i = 1, #fallbackKeys do
    key = fallbackKeys:sub(i, i):upper()
    if not bound[key] then
      return key, true
    end
  end
end

local function persistentAlert(message)
  local win = hs.window.focusedWindow()
  return hs.alert.show(message, hs.alert.defaultStyle, win:screen(), true)
end

local eventTap = nil

local function openHarpSpoon()
  local bound = getBoundKeys()
  hs.alert.closeAll()
  local apps = {}
  local displayStrs = {"HarpSpoon - (ESC to quit)"}

  for _, app in ipairs(hs.application.runningApplications()) do
    if app:kind() == 1 then
      local key, isNew = getOrAssignKey(app:name(), bound)
      if isNew then
        bound[key] = true
      end

      apps[key] = app:bundleID()
      table.insert(displayStrs, string.format("  %s  →  %s", key, app:name()))
    end
  end

  table.sort(apps)

  persistentAlert(table.concat(displayStrs, "\n"))

  eventTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
    local key = hs.keycodes.map[e:getKeyCode()]:upper()

    if key == "ESCAPE" then
      hs.alert.closeAll()
      eventTap:stop()
      eventTap = nil
      return true
    end

    local appID = apps[key]
    if not appID then
      hs.alert.show(key)
      return true
    end

    hs.alert.closeAll()
    hs.application.launchOrFocusByBundleID(appID)

    eventTap:stop()
    eventTap = nil

    return true

  end)
  eventTap:start()
end

hs.hotkey.bind(mods.windows, "SPACE", openHarpSpoon)
