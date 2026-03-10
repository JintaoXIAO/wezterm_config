---@module "events.update-status"
---@author sravioli
---@license GNU-GPLv3

---macOS Terminal style: minimal status bar.
---With use_fancy_tab_bar = true, the native tab bar handles most UI.
---This event is kept minimal -- no powerline segments.

---@diagnostic disable: undefined-field

local wt = require "wezterm"

wt.on("update-status", function(_, _)
  ---intentionally empty: macOS Terminal does not use a status bar.
  ---The native tab bar and window title provide all necessary info.
end)
