-- alacritty customizations
--   visual bell: 100ms
--   color scheme: solarized light
--   decorations: none
--   dimensions: 150x50
-- color_scheme = 'Batman',

local wezterm = require "wezterm"
return {
  unix_domains = {
    {
      name = "unix",
    },
  },
  color_scheme = "Solarized (light) (terminal.sexy)",
  font = wezterm.font "FiraCode Nerd Font",
  font_size = 14,
  window_frame = {
    font = wezterm.font "FiraCode Nerd Font",
    font_size = 14,
  },
  use_fancy_tab_bar = false,
}
