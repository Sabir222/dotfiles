local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 18
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.color_scheme = "Royal (Gogh)"
config.enable_tab_bar = false
config.window_decorations = "NONE"
return config
