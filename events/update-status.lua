---@module "events.update-status"
---@author sravioli
---@license GNU-GPLv3

---Bottom tab bar right-status: show current working directory with folder icon.

---@diagnostic disable: undefined-field

local wt = require "wezterm"
local Utils = require "utils"
local fs = Utils.fn.fs
local Icon = Utils.class.icon
local Layout = Utils.class.layout

wt.on("update-status", function(window, pane)
  local theme = window:effective_config().resolved_palette

  ---get cwd
  local cwd = ""
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local full_cwd = type(cwd_uri) == "userdata" and cwd_uri.file_path or cwd_uri
    ---show last two path components for context: parent/current
    local parts = {}
    for part in full_cwd:gmatch "[^/]+" do
      parts[#parts + 1] = part
    end
    if #parts >= 2 then
      cwd = parts[#parts - 1] .. "/" .. parts[#parts]
    elseif #parts == 1 then
      cwd = parts[1]
    else
      cwd = "~"
    end
  end

  local tab_bg = theme.tab_bar_style
    and theme.tab_bar_style.background
    or (theme.tab_bar and theme.tab_bar.background)
    or "#063D1E"

  local fg = "#C0DCC5"
  local accent = "#73FA91"

  local rl = Layout:new "RightStatus"
  rl:append(tab_bg, accent, " " .. Icon.Folder .. " ", { "Bold" })
  rl:append(tab_bg, fg, cwd .. "  ")

  window:set_right_status(wt.format(rl))
end)
