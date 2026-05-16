local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

local config = wezterm.config_builder()

local scheme = wezterm.get_builtin_color_schemes()["Catppuccin Mocha"]
scheme.background = "black"
config.color_schemes = {
  ["Catppuccin Mocha"] = scheme,
}

config.font = wezterm.font("CommitMono Nerd Font Mono")
config.font_size = 14
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.window_decorations = "RESIZE"

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.window_background_opacity = 0.95
config.macos_window_background_blur = 10
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.scrollback_lines = 10000
config.window_padding = { left = 4, right = 4, top = 4, bottom = 0 }
config.max_fps = 120
config.automatically_reload_config = true
config.audible_bell = "Disabled"
config.adjust_window_size_when_changing_font_size = false

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[\bgh:([\w-]+)/([\w.-]+)#(\d+)\b]],
  format = "https://github.com/$1/$2/issues/$3",
})

wezterm.on("window-config-reloaded", function(window)
  local overrides = window:get_config_overrides() or {}
  local next_scheme = scheme_for_appearance(window:get_appearance())
  if overrides.color_scheme ~= next_scheme then
    overrides.color_scheme = next_scheme
    window:set_config_overrides(overrides)
  end
end)

local keys = {
  { key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "CMD",       action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "w", mods = "CMD",       action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}
for key, dir in pairs({ h = "Left", l = "Right", k = "Up", j = "Down" }) do
  table.insert(keys, {
    key = key,
    mods = "CMD|SHIFT",
    action = wezterm.action.ActivatePaneDirection(dir),
  })
end
config.keys = keys

return config
