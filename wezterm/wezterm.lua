local wezterm = require 'wezterm'
local config = {}

-- font
config.font = wezterm.font('CaskaydiaCove Nerd Font Mono', { weight = 'DemiBold' })
config.font_size = 18.0

-- colors
config.color_scheme = 'OneHalfDark'
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.colors = { background = 'rgb(0,0,0)' }

return config