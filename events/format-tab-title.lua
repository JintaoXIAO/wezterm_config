---@module "events.format-tab-title"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable: undefined-field

local wt = require "wezterm"
local fs = require("utils.fn").fs

---Provide tab title text; the fancy tab bar handles the rounded-rectangle chrome.
wt.on("format-tab-title", function(tab, _, _, config, _, _)
  if not config.enable_tab_bar then
    return
  end

  local pane = tab.active_pane

  ---get cwd (basename only)
  local cwd = ""
  if pane.current_working_dir then
    local full_cwd = type(pane.current_working_dir) == "userdata"
        and pane.current_working_dir.file_path
      or pane.current_working_dir
    cwd = fs.basename(full_cwd)
  end
  if cwd == "" then
    cwd = (tab.tab_title and #tab.tab_title > 0) and tab.tab_title or pane.title
  end

  ---unseen output indicator
  local unseen = false
  for _, p in ipairs(tab.panes) do
    if p.has_unseen_output then
      unseen = true
      break
    end
  end

  local idx = tab.tab_index + 1
  local indicator = unseen and "●" or tostring(idx)

  ---wide padding on both sides to push tabs apart
  return ("   %s  %s   "):format(indicator, cwd)
end)
