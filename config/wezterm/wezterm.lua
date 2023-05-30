-- alacritty customizations
--   visual bell: 100ms
--   color scheme: solarized light
--   decorations: none
--   dimensions: 150x50
-- color_scheme = 'Batman',
-- window_frame = {
--   font = wezterm.font "FiraCode Nerd Font",
--   font_size = 14,
-- },
local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local color_scheme = 'Solarized (light) (terminal.sexy)'
local colors = wezterm.color.get_builtin_schemes()[color_scheme]
-- set -g status-fg colour245 # base1

wezterm.on("update-status", function(window, pane)
  -- local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'

  -- Make it italic and underlined
  -- window:set_right_status(wezterm.format {
  --   { Attribute = { Underline = 'Single' } },
  --   { Attribute = { Italic = true } },
  --   { Text = 'Hello ' .. date },
  -- })
  local time = wezterm.strftime " %H:%M:%S "
  local date = wezterm.strftime " %d-%b-%y "
  window:set_right_status(wezterm.format {
    { Foreground = { Color = colors.foreground } },
    { Background = { Color = colors.background } },
    { Text = "" },
    { Foreground = { Color = colors.background } },
    { Background = { Color = colors.foreground } },
    { Text = time },
    { Foreground = { Color = colors.background } },
    { Background = { Color = colors.foreground } },
    { Text = "" },
    { Foreground = { Color = colors.foreground } },
    { Background = { Color = colors.background } },
    { Text = date },
  })
end)

return {
  unix_domains = {
    {
      name = "unix",
    },
  },
  color_scheme = color_scheme,
  colors = {
    tab_bar = {
      background = colors.background,
      foreground = colors.foreground,
      -- # Current window status
      -- set -g window-status-current-style fg=white,bg=colour33
      active_tab = {
        fg_color = colors.background,
        bg_color = "blue",
      },
    },
  },
  font = wezterm.font "FiraCode Nerd Font",
  font_size = 16,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
}

-- # Basic status bar colors
-- # Left side of status bar
-- set -g status-left-style fg=colour243,bg=white
-- set -g status-left-length 40
-- set -g status-left "#[fg=white,bg=colour61,nobold] #S #[fg=colour61,bg=white]"
-- # Window status
-- set -g window-status-format "  #I #W  "
-- set -g window-status-current-format "#[fg=white,bg=colour33]#[fg=white,nobold] #I #W #[fg=colour33,bg=white,nobold]"
-- # Window with activity status
-- set -g window-status-activity-style fg=white,bg=colour243
-- # Window separator
-- set -g window-status-separator ""
-- # Window status alignment
-- set -g status-justify left
