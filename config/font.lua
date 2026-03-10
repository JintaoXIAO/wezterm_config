---@diagnostic disable: undefined-field

local wt = require "wezterm"
local is_mac = require("utils.fn").fs.platform().is_mac

local Config = {}

Config.adjust_window_size_when_changing_font_size = false
Config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
Config.anti_alias_custom_block_glyphs = true

---macOS: Menlo (Terminal.app default)
---Windows: Consolas (cmd.exe / PowerShell default)
if is_mac then
  Config.font = wt.font_with_fallback {
    { family = "Menlo", weight = "Regular" },
    { family = "Apple Color Emoji" },
    { family = "Noto Color Emoji" },
  }
  Config.font_size = 14.0
else
  Config.font = wt.font_with_fallback {
    { family = "Consolas", weight = "Regular" },
    { family = "Segoe UI Emoji" },
    { family = "Noto Color Emoji" },
  }
  Config.font_size = 14.0
end

Config.line_height = 1.0
Config.underline_position = -2.5
Config.underline_thickness = "1px"
Config.warn_about_missing_glyphs = false

---italic font rules
if is_mac then
  Config.font_rules = {
    {
      intensity = "Normal",
      italic = true,
      font = wt.font_with_fallback {
        { family = "Menlo", style = "Italic", weight = "Regular" },
      },
    },
    {
      intensity = "Bold",
      italic = true,
      font = wt.font_with_fallback {
        { family = "Menlo", style = "Italic", weight = "Bold" },
      },
    },
  }
else
  Config.font_rules = {
    {
      intensity = "Normal",
      italic = true,
      font = wt.font_with_fallback {
        { family = "Consolas", style = "Italic", weight = "Regular" },
      },
    },
    {
      intensity = "Bold",
      italic = true,
      font = wt.font_with_fallback {
        { family = "Consolas", style = "Italic", weight = "Bold" },
      },
    },
  }
end

return Config
