---Grass - Inspired by macOS Terminal's Grass profile
---@module "picker.assets.colorschemes.grass"
---@author sravioli
---@license GNU-GPLv3

---@class PickList
local M = {}

local color = require("utils").fn.color

M.scheme = {
  background = "#13773D",
  foreground = "#E3F6E8",
  cursor_bg = "#73FA91",
  cursor_fg = "#0A4422",
  cursor_border = "#73FA91",
  selection_fg = "#E3F6E8",
  selection_bg = "#0E5C2F",
  scrollbar_thumb = "#0E5C2F",
  split = "#3DA06A",
  ansi = {
    "#0A4422",
    "#E05252",
    "#5EF08C",
    "#E8DA5E",
    "#5EB3F0",
    "#CF6FED",
    "#5EE8C8",
    "#D0E8D5",
  },
  brights = {
    "#3DA06A",
    "#FF7A7A",
    "#89FFB0",
    "#FFEF82",
    "#82CFFF",
    "#E09BFF",
    "#82FFE0",
    "#F0FFF4",
  },
  indexed = { [16] = "#FFA066", [17] = "#FF6B6B" },
  compose_cursor = "#73FA91",
  visual_bell = "#0A4422",
  copy_mode_active_highlight_bg = { Color = "#0E5C2F" },
  copy_mode_active_highlight_fg = { Color = "#E3F6E8" },
  copy_mode_inactive_highlight_bg = { Color = "#3DA06A" },
  copy_mode_inactive_highlight_fg = { Color = "#0A4422" },
  quick_select_label_bg = { Color = "#FF7A7A" },
  quick_select_label_fg = { Color = "#E3F6E8" },
  quick_select_match_bg = { Color = "#FFEF82" },
  quick_select_match_fg = { Color = "#0A4422" },
  tab_bar = {
    background = "#0D6434",
    inactive_tab_edge = "#3DA06A",
    active_tab = { bg_color = "#73FA91", fg_color = "#0A4422" },
    inactive_tab = { bg_color = "#0E5C2F", fg_color = "#D0E8D5" },
    inactive_tab_hover = { bg_color = "#13773D", fg_color = "#E3F6E8", italic = true },
    new_tab = { bg_color = "#0E5C2F", fg_color = "#D0E8D5" },
    new_tab_hover = { bg_color = "#3DA06A", fg_color = "#E3F6E8", italic = true },
  },
}

function M.get()
  return { id = "grass", label = "Grass" }
end

function M.activate(Config, callback_opts)
  local theme = M.scheme
  color.set_scheme(Config, theme, callback_opts.id)
end

return M
