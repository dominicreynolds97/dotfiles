local mods = require("modules.mods")
local bindings = require("modules.bindings")

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
  if #wins < 2 then
    hs.alert.show("No additional windows")
    return
  end

  table.sort(wins, function(a, b) return a:id() < b:id() end)

  local focused = hs.window.focusedWindow()
  for i, win in ipairs(wins) do
    if win == focused then
      wins[i % #wins + 1]:focus()
      return
    end
  end
end

local function loadWindowBindings()
  hs.hotkey.bind(mods.windows, "F", toggleFullscreen)
  hs.hotkey.bind(mods.windows, "M", maximize)
  hs.hotkey.bind(mods.windows, "C", cycleFocusedApp)

  for key, dir in pairs(bindings.directions) do
    hs.hotkey.bind(mods.windows, key, function() moveToScreen(dir) end)
    hs.hotkey.bind(mods.apps, key, function() focusScreen(dir) end)
  end
end

loadWindowBindings()
