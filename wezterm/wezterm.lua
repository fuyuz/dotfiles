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

config.window_frame = {
	font_size = 13.0,
}

local function hash_string(str)
	local hash = 5381
	for i = 1, #str do
		hash = ((hash * 33) + string.byte(str, i)) % 0xFFFFFFFF
	end
	return hash
end

local function hsl_to_rgb(h, s, l)
	local r, g, b
	if s == 0 then
		r, g, b = l, l, l
	else
		local function hue2rgb(p, q, t)
			if t < 0 then t = t + 1 end
			if t > 1 then t = t - 1 end
			if t < 1 / 6 then return p + (q - p) * 6 * t end
			if t < 1 / 2 then return q end
			if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
			return p
		end
		local q = l < 0.5 and l * (1 + s) or l + s - l * s
		local p = 2 * l - q
		r = hue2rgb(p, q, h + 1 / 3)
		g = hue2rgb(p, q, h)
		b = hue2rgb(p, q, h - 1 / 3)
	end
	return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

local function workspace_color(name)
	local hash = hash_string(name)
	local hue = (hash % 360) / 360
	local saturation = 0.7
	local lightness = 0.3
	local r, g, b = hsl_to_rgb(hue, saturation, lightness)
	return string.format("#%02x%02x%02x", r, g, b)
end

wezterm.on("update-status", function(window, pane)
	local workspace = window:active_workspace()
	local bg_color = workspace_color(workspace)

	window:set_left_status(wezterm.format({
		{ Background = { Color = bg_color } },
		{ Foreground = { Color = "#ffffff" } },
		{ Text = "   " .. workspace .. "   " },
	}))

	window:set_config_overrides({
		colors = {
			background = "rgb(0,0,0)",
			tab_bar = {
				background = bg_color,
			},
		},
	})
end)

return config
