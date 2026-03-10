---@module "events.format-tab-title"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable: undefined-field

local wt = require "wezterm"
local fs = require("utils.fn").fs

---macOS Terminal style tab titles: "process — directory"
wt.on("format-tab-title", function(tab, _, _, config, _, _)
  if not config.enable_tab_bar then
    return
  end

  local pane = tab.active_pane

  ---get process name
  local proc = pane.foreground_process_name or ""
  proc = fs.basename(proc):gsub("%.exe$", "")

  ---get cwd
  local cwd = ""
  if pane.current_working_dir then
    local full_cwd = type(pane.current_working_dir) == "userdata"
        and pane.current_working_dir.file_path
      or pane.current_working_dir
    cwd = fs.basename(full_cwd)
  end

  ---format like macOS Terminal: "zsh — project-dir"
  if cwd ~= "" and proc ~= "" then
    return proc .. " — " .. cwd
  elseif proc ~= "" then
    return proc
  end

  local title = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or pane.title
  return title
end)
