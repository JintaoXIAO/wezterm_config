---@module "events.format-window-title"
---@author sravioli
---@license GNU-GPLv3

local wt = require "wezterm"
local fs = require("utils.fn").fs

---macOS Terminal style window title: "process — directory"
wt.on("format-window-title", function(tab, pane, tabs, _, _)
  local zoomed = ""
  if tab.active_pane.is_zoomed then
    zoomed = "[Z] "
  end

  local index = ""
  if #tabs > 1 then
    index = ("[%d/%d] "):format(tab.tab_index + 1, #tabs)
  end

  ---process name
  local proc = fs.basename(pane.foreground_process_name or ""):gsub("%.exe$", "")

  ---cwd
  local cwd = ""
  if pane.current_working_dir then
    cwd = fs.basename(
      type(pane.current_working_dir) == "userdata" and pane.current_working_dir.file_path
        or pane.current_working_dir
    )
  end

  local title = proc
  if cwd ~= "" then
    title = title .. " — " .. cwd
  end

  return zoomed .. index .. title
end)
