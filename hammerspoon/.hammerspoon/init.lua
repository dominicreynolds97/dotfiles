require("modules.windows")
require("modules.splits")
local HarpSpoon = require("modules.harpspoon")

local apps = require("modules.bindings").apps

hs.window.animationDuration = 0

HarpSpoon.new():setup({
  mod = {"cmd", "alt", "ctrl"},
  apps = apps
}):start()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)

hs.alert.show("Hammerspoon loaded")
