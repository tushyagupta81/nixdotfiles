-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

-- config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font = wezterm.font("0xProto Nerd Font", { weight = "Regular" })
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("MesloLGS NF")
-- config.font = wezterm.font("Source Code Pro for Powerline")
config.font_size = is_linux() and 12 or 16

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.color_scheme = "Rasi (terminal.sexy)"

local h = {}

h.get_random_entry = function(tbl)
	local keys = {}
	for key, _ in ipairs(tbl) do
		table.insert(keys, key)
	end
	local randomKey = keys[math.random(1, #keys)]
	return tbl[randomKey]
end

local M = {}

M.get_wallpaper = function(dir)
	local wallpapers = {}
	for _, v in ipairs(wezterm.glob(dir)) do
		if not (string.match(v, "%.git$") or string.match(v, "%.DS_Store$")) then
			table.insert(wallpapers, v)
		end
	end
	local wallpaper = h.get_random_entry(wallpapers)
	return {
		source = { File = { path = wallpaper } },
		height = "Cover",
		width = "Cover",
		horizontal_align = "Center",
		repeat_x = "Repeat",
		repeat_y = "Repeat",
		opacity = 1,
		hsb = {
			brightness = 0.02,
			hue = 1.0,
			saturation = 1.0,
		},
		-- speed = 200,
	}
end

local path = os.getenv("HOME") .. "/nixdotfiles/wallpapers/**"

config.background = { M.get_wallpaper(path) }

local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
