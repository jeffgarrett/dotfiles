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
    },
  },
}
config.enable_scroll_bar = true
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 14
config.tab_bar_style = {
  window_hide = wezterm.format {
    { Foreground = { Color = "#cccccc" } },
    { Text = " " .. wezterm.nerdfonts.cod_chrome_minimize .. " " },
  },
  window_hide_hover = wezterm.format {
    { Foreground = { Color = '#268bd2' } },
    { Background = { Color = colors.background } },
    { Text = " " .. wezterm.nerdfonts.cod_chrome_minimize .. " " },
  },
  window_maximize = wezterm.format {
    { Foreground = { Color = "#cccccc" } },
    { Text = " " .. wezterm.nerdfonts.cod_chrome_maximize .. " " },
  },
  window_maximize_hover = wezterm.format {
    { Foreground = { Color = '#268bd2' } },
    { Background = { Color = colors.background } },
    { Text = " " .. wezterm.nerdfonts.cod_chrome_maximize .. " " },
  },
  window_close = wezterm.format {
    { Foreground = { Color = "#cccccc" } },
    { Text = " " .. wezterm.nerdfonts.cod_chrome_close .. " " },
  },
  window_close_hover = wezterm.format {
    { Foreground = { Color = '#268bd2' } },
    { Background = { Color = colors.background } },
    { Attribute = { Italic = false } },
    { Text = " " .. wezterm.nerdfonts.cod_chrome_close .. " " },
  },
}
config.use_fancy_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, pane, config, hover, max_width)
    local foreground = colors.foreground
    local background = colors.background

    if tab.is_active then
      foreground = '#eee8d5'
      background = '#268bd2'
    end

    local title = tab.tab_title
    if not title or #title == 0 then
      title = tab.active_pane.title
    end
    title = wezterm.truncate_right(title, max_width - 4)

    if tab.is_active then
      return {
        { Background = { Color = colors.background } },
        { Foreground = { Color = background } },
        { Text = wezterm.nerdfonts.pl_right_hard_divider },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = ' ' .. title .. ' ' },
        { Background = { Color = background } },
	{ Foreground = { Color = colors.background } },
        { Text = wezterm.nerdfonts.pl_right_hard_divider },
      }
    else
      return {
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = '  ' .. title .. '  ' },
      }
    end
  end
)

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
