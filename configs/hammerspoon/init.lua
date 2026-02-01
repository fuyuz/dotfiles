-- Window half/half bindings
local hyper = {"alt"}

local function move_to_half(side)
  local win = hs.window.focusedWindow()
  if not win then return end

  local f = win:screen():frame()
  if side == "left" then
    win:setFrame({ x = f.x, y = f.y, w = f.w / 2, h = f.h })
  else
    win:setFrame({ x = f.x + (f.w / 2), y = f.y, w = f.w / 2, h = f.h })
  end
end

hs.hotkey.bind(hyper, "H", function() move_to_half("left") end)
hs.hotkey.bind(hyper, "L", function() move_to_half("right") end)

hs.hotkey.bind(hyper, "J", function()
  local win = hs.window.focusedWindow()
  if not win then return end
  win:maximize()
end)

local function launch(app)
  hs.application.launchOrFocus(app)
end

-- App shortcuts (Alt + number)
hs.hotkey.bind(hyper, "1", function() launch("WezTerm") end)
hs.hotkey.bind(hyper, "2", function() launch("Arc") end)
hs.hotkey.bind(hyper, "3", function() launch("Slack") end)
