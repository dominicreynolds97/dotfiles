local bindings = require("modules.bindings")
local mods = require("modules.mods")

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


local function loadAppBindings()
  for key, appName in pairs(bindings.apps) do
    hs.hotkey.bind(mods.apps, key, function() focusApp(appName) end)
  end
end

loadAppBindings()
