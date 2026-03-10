local Utils = require "utils"
local color = Utils.fn.color
local is_mac = Utils.fn.fs.platform().is_mac

---@diagnostic disable-next-line: undefined-field
local G = require("wezterm").GLOBAL

local Config = {}

Config.color_schemes = color.get_schemes()
Config.color_scheme = "grass"

local theme = Config.color_schemes[Config.color_scheme]

Config.background = {
  {
    source = { Color = theme.background },
    width = "100%",
    height = "100%",
    opacity = G.opacity or 1,
  },
}

Config.bold_brightens_ansi_colors = "BrightAndBold"

---char select and command palette
Config.char_select_bg_color = theme.brights[6]
Config.char_select_fg_color = theme.background
Config.char_select_font_size = 12

Config.command_palette_bg_color = theme.brights[6]
Config.command_palette_fg_color = theme.background
Config.command_palette_font_size = 14
Config.command_palette_rows = 20

---cursor - block cursor with blink
Config.cursor_blink_ease_in = "EaseIn"
Config.cursor_blink_ease_out = "EaseOut"
Config.cursor_blink_rate = 500
Config.default_cursor_style = "BlinkingBlock"
Config.cursor_thickness = 2
Config.force_reverse_video_cursor = false

Config.enable_scroll_bar = false

Config.hide_mouse_cursor_when_typing = true

---text blink
Config.text_blink_ease_in = "EaseIn"
Config.text_blink_ease_out = "EaseOut"
Config.text_blink_rapid_ease_in = "Linear"
Config.text_blink_rapid_ease_out = "Linear"
Config.text_blink_rate = 500
Config.text_blink_rate_rapid = 250

---visual bell
Config.audible_bell = "SystemBeep"
Config.visual_bell = {
  fade_in_function = "EaseOut",
  fade_in_duration_ms = 200,
  fade_out_function = "EaseIn",
  fade_out_duration_ms = 200,
}

---window appearance - browser-style integrated tabs at the very top
Config.window_padding = { left = 5, right = 5, top = 5, bottom = 5 }
Config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
Config.window_background_opacity = 1.0

---platform-specific window chrome
if is_mac then
  Config.macos_window_background_blur = 0
  Config.native_macos_fullscreen_mode = true
  Config.integrated_title_button_alignment = "Left"
  Config.integrated_title_button_style = "MacOsNative"
  Config.integrated_title_buttons = { "Close", "Hide", "Maximize" }
else
  Config.integrated_title_button_alignment = "Right"
  Config.integrated_title_button_style = "Windows"
  Config.integrated_title_buttons = { "Hide", "Maximize", "Close" }
end

---window frame (for fancy/native tab bar)
Config.window_frame = {
  font_size = 13.0,
  active_titlebar_bg = "#0D6434",
  inactive_titlebar_bg = "#0A4422",
}

---exit behavior
Config.clean_exit_codes = { 0, 130 }
Config.exit_behavior = "CloseOnCleanExit"
Config.exit_behavior_messaging = "None"
Config.skip_close_confirmation_for_processes_named = {
  "bash",
  "sh",
  "zsh",
  "fish",
  "tmux",
  "nu",
  "login",
  "cmd.exe",
  "pwsh.exe",
  "powershell.exe",
}
Config.window_close_confirmation = "AlwaysPrompt"

color.set_tab_button(Config, theme)

return Config
