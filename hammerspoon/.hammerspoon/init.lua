require("modules.apps")
require("modules.windows")
require("modules.splits")
require("modules.harpspoon")

hs.window.animationDuration = 0

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

hs.alert.show("Hammerspoon loaded")
