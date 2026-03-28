-- modules/harpspoon.lua

---@class HarpSpoonConfig
---@field mod string[]
---@field apps table<string, string>
---@field fallbackKeys string?
---@field openGuiKey string?
---@field addAppKey string?

---@class HarpSpoonBinding
---@field key string
---@field bundleID string
---@field name string

local HarpSpoon = {}
HarpSpoon.__index = HarpSpoon

local fallbackKeys = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local defaultMod = {"ctrl", "alt", "cmd"}
local stateDir = os.getenv("HOME") .. "/.local/state/harpspoon"
local stateFile = stateDir .. "/bindings.json"

-- State persistence

local function ensureStateDir()
  os.execute("mkdir -p " .. stateDir)
end

function HarpSpoon:saveState()
  ensureStateDir()
  local data = hs.json.encode(self.apps, true)
  local f = io.open(stateFile, "w")
  if f then
    f:write(data)
    f:close()
  end
end

function HarpSpoon:loadState()
  local f = io.open(stateFile, "r")
  if not f then return end
  local data = f:read("*a")
  f:close()
  local decoded = hs.json.decode(data)
  if decoded then
    self.apps = decoded
  end
end

-- Helpers

function HarpSpoon:resolveApps(apps)
  local resolved = {}
  for key, name in pairs(apps) do
    local app = hs.application.get(name)
    resolved[key] = {
      key = key,
      name = name,
      bundleID = app and app:bundleID()
    }
  end
  return resolved
end

function HarpSpoon:bindApp(key, entry)
  if self.hotkeys[key] then
    self.hotkeys[key]:delete()
    self.hotkeys[key] = nil
  end
  self.hotkeys[key] = hs.hotkey.bind(self.mod, key, function()
    self:focusApp(entry)
  end)
end

function HarpSpoon:focusApp(entry)
  hs.application.launchOrFocusByBundleID(entry.bundleID)
end

function HarpSpoon:persistentAlert(message)
  local win = hs.window.focusedWindow()
  return hs.alert.show(message, hs.alert.defaultStyle, win:screen(), true)
end

function HarpSpoon:getBoundKeys()
  local bound = {}
  for key, _ in pairs(self.apps) do
    bound[key:upper()] = true
  end
  return bound
end

function HarpSpoon:getOrAssignKey(appID, bound)
  for key, bundleID in pairs(self.apps) do
    if bundleID == appID then return key, false end
  end

  local key = string.sub(appID, 0, 1):upper()
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

function HarpSpoon:stopEventTap()
  if self.eventTap then
    self.eventTap:stop()
    self.eventTap = nil
  end
end

-- App flow

function HarpSpoon:confirmReplace(key, newEntry, onConfirm, onCancel)
  local existing = self.apps[key]
  self:persistentAlert(string.format(
    "HarpSpoon\n\n  %s is already bound to %s\n\n  Y  confirm replace with %s\n  N  cancel",
    key, existing.name, newEntry.name
  ))

  self.eventTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
    local pressed = hs.keycodes.map[e:getKeyCode()]:upper()

    if pressed == "Y" then
      hs.alert.closeAll()
      self:stopEventTap()
      onConfirm()
    elseif pressed == "N" then
      hs.alert.closeAll()
      self:stopEventTap()
      if onCancel then onCancel() end
    end

    return true
  end)

  self.eventTap:start()
end

function HarpSpoon:promptForKey(appName, bundleID)
  self:persistentAlert(string.format(
    "HarpSpoon\n\n Adding: %s\n\n Press a key to assign (ESC to cancel)",
    appName
  ))

  self.eventTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
    local key = hs.keycodes.map[e:getKeyCode()]:upper()

    if key == "ESCAPE" then
      hs.alert.closeAll()
      self:stopEventTap()
      return true
    end

    if not key:match("^[A-Z]$") then return true end

    hs.alert.closeAll()
    self:stopEventTap()

    local entry = { key = key, name = appName, bundleID = bundleID }

    if self.apps[key] then
      self:confirmReplace(key, entry, function()
        self.apps[key] = entry
        self:bindApp(key, entry)
        self:saveState()
        hs.alert.show(string.format("HarpSpoon: %s → %s", key, appName))
      end, nil)
    else
      self.apps[key] = entry
      self:bindApp(key, entry)
      self:saveState()
      hs.alert.show(string.format("HarpSpoon: %s → %s", key, appName))
    end

    return true
  end)

  self.eventTap:start()
end

function HarpSpoon:addCurrentApp()
  local app = hs.application.frontmostApplication()
  if not app then return end

  local appName = app:name()
  local bundleID = app:bundleID()

  for key, entry in pairs(self.apps) do
    if entry.bundleID == bundleID then
      hs.alert.show(string.format("HarpSpoon: %s already bound to %s", appName, key))
      return
    end
  end

  self:promptForKey(appName, bundleID)
end

function HarpSpoon:open()
  local bound = self:getBoundKeys()
  hs.alert.closeAll()

  local appIDs = {}
  local displayStrs = {"HarpSpoon - (ESC to quit)"}

  for _, app in ipairs(hs.application.runningApplications()) do
    if app:kind() == 1 then
      local key, isNew = self:getOrAssignKey(app:bundleID(), bound)
      if isNew then
        bound[key] = true
      end

      appIDs[key] = app:bundleID()
      table.insert(displayStrs, string.format("  %s  →  %s", key, app:name()))
    end
  end

  table.sort(displayStrs)

  self:persistentAlert(table.concat(displayStrs, "\n"))

  self.eventTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
    local key = hs.keycodes.map[e:getKeyCode()]:upper()

    if key == "ESCAPE" then
      hs.alert.closeAll()
      self:stopEventTap()
      return true
    end

    local appID = appIDs[key]
    if not appID then return true end

    hs.alert.closeAll()
    hs.application.launchOrFocusByBundleID(appID)
    self:stopEventTap()
    return true

  end)
  self.eventTap:start()
end

-- Setup

function HarpSpoon.new()
  local self = setmetatable({}, HarpSpoon)

  self.mod = defaultMod
  self.apps = {}
  self.hotkeys = {}
  self.fallbackKeys = fallbackKeys
  self.openGuiKey = "SPACE"
  self.addAppKey = "RETURN"
  self.eventTap = nil

  return self
end

function HarpSpoon:setup(config)
  ---@type HarpSpoonConfig

  self.mod = config.mod or defaultMod
  self.apps = self:resolveApps(config.apps)
  self.fallbackKeys = config.fallbackKeys or fallbackKeys
  self.openGuiKey = config.openGuiKey or "SPACE"
  self.addAppKey = config.addAppKey or "RETURN"

  self:loadState()
  self:saveState()

  return self
end


function HarpSpoon:loadAppBindings()
  for key, entry in pairs(self.apps) do
    self:bindApp(key, entry)
  end
end

function HarpSpoon:start()
  self:loadAppBindings()
  hs.hotkey.bind(self.mod, self.openGuiKey, function() self:open() end)
  hs.hotkey.bind(self.mod, self.addAppKey, function() self:addCurrentApp() end)
end

return HarpSpoon
