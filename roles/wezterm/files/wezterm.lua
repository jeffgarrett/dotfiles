local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- TODO: debug overlay doesn't work
-- config.allow_win32_input_mode = false

-- Do not check for updates
config.check_for_updates = false

-- Visual style: Solarized
local color_scheme = 'Solarized (light) (terminal.sexy)'
local colors = wezterm.color.get_builtin_schemes()[color_scheme]
config.color_scheme = color_scheme
config.colors = {
  tab_bar = {
    background = colors.background,
    active_tab = {
      fg_color = '#eee8d5',
      bg_color = '#268bd2',
    },
    inactive_tab = {
      fg_color = colors.foreground,
      bg_color = colors.background,
    },
    new_tab = {
      fg_color = colors.foreground,
      bg_color = colors.background,
    }
  },
}
config.enable_scroll_bar = true
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 14
config.use_fancy_tab_bar = false

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on("update-status", function(window, pane)
  local nf_right_hard_divider = utf8.char(0xe0b2)
  local time = wezterm.strftime " %H:%M:%S "
  local date = wezterm.strftime " %d-%b-%y "

  -- Make it italic and underlined
  -- window:set_right_status(wezterm.format {
  --   { Attribute = { Underline = 'Single' } },
  --   { Attribute = { Italic = true } },
  --   { Text = 'Hello ' .. date },
  -- })
  window:set_right_status(wezterm.format {
    { Foreground = { Color = colors.foreground } },
    { Background = { Color = colors.background } },
    { Text = nf_right_hard_divider },
    { Foreground = { Color = colors.background } },
    { Background = { Color = colors.foreground } },
    { Text = time },
    { Foreground = { Color = colors.background } },
    { Background = { Color = colors.foreground } },
    { Text = nf_right_hard_divider },
    { Foreground = { Color = colors.foreground } },
    { Background = { Color = colors.background } },
    { Text = date },
  })
end)

return config
-- return {
--   unix_domains = {
--     {
--       name = "unix",
--     },
--   },
--   window_padding = {
--     left = 0,
--     right = 0,
--     top = 0,
--     bottom = 0,
--   },
-- }

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
-- set -g status-fg colour245 # base1
    -- # Current window status
    -- set -g window-status-current-style fg=white,bg=colour33
