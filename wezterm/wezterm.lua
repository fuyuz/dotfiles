local wezterm = require("wezterm")
local config = {}

-- font
config.font = wezterm.font_with_fallback({
	{ family = "JetBrainsMono Nerd Font", weight = "DemiBold" },
	"ヒラギノ角ゴシック",
})
config.font_size = 16.0

-- colors
config.color_scheme = "OneHalfDark"
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20
config.colors = { background = "rgb(0,0,0)" }

-- mac option key settigns
config.send_composed_key_when_left_alt_is_pressed = true

-- window settings
config.leader = {
	key = "q",
	mods = "CTRL",
	timeout_milliseconds = 2000,
}
config.keys = {
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "=",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},
	{
		mods = "LEADER",
		key = "q",
		action = wezterm.action.SendKey({ key = "q", mods = "CTRL" }),
	},
}

config.window_decorations = "RESIZE"
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

-- stop termianl bells
config.audible_bell = "Disabled"

-- notification for claude completion
wezterm.on('bell', function(window, pane)
	local foreground_process = pane:get_foreground_process_info()
	if foreground_process and foreground_process.name and foreground_process.name:find('claude') then
		window:toast_notification('Claude Code', 'Task completed', nil, 4000)
	end
end)

return config
