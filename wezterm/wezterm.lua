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
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action_callback(function(window, pane)
			local workspaces = wezterm.mux.get_workspace_names()
			local choices = {
				{ id = "__create_new__", label = "+ Create New Workspace" },
			}
			for _, name in ipairs(workspaces) do
				table.insert(choices, { id = name, label = name })
			end

			window:perform_action(
				wezterm.action.InputSelector({
					title = "Select or Create Workspace",
					choices = choices,
					fuzzy = true,
					action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
						if id == "__create_new__" then
							inner_window:perform_action(
								wezterm.action.PromptInputLine({
									description = "Enter new workspace name:",
									action = wezterm.action_callback(function(win, p, line)
										if line and #line > 0 then
											win:perform_action(wezterm.action.SwitchToWorkspace({ name = line }), p)
										end
									end),
								}),
								inner_pane
							)
						elseif id then
							inner_window:perform_action(wezterm.action.SwitchToWorkspace({ name = id }), inner_pane)
						end
					end),
				}),
				pane
			)
		end),
	},
}

config.window_decorations = "RESIZE"
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.front_end = "OpenGL"

config.use_ime = true

return config
