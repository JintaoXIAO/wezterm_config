---@module "mappings.default"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local key = require("utils.fn").key
local is_mac = require("utils.fn").fs.platform().is_mac

local Config = {}

Config.disable_default_key_bindings = true

---Platform-aware modifier keys:
---  macOS:   Cmd (W)            / Cmd+Shift (W-S)       / Cmd+Alt (W-M)
---  Windows: Ctrl+Shift (C-S)   / Ctrl+Alt (C-M)        / Alt+Shift (M-S)
local mod = is_mac and "W" or "C-S"
local mod2 = is_mac and "W-S" or "C-M"
local mod_alt = is_mac and "W-M" or "M-S"

local mappings = {
  ---Quit application: Cmd+Q (macOS) / Ctrl+Shift+Q (Windows)
  { "<" .. mod .. "-q>", act.QuitApplication, "quit" },

  ---Tab management
  { "<" .. mod .. "-t>", act.SpawnTab "CurrentPaneDomain", "new tab" },
  { "<" .. mod .. "-w>", act.CloseCurrentTab { confirm = true }, "close tab" },
  { "<" .. mod2 .. "-[>", act.ActivateTabRelative(-1), "prev tab" },
  { "<" .. mod2 .. "-]>", act.ActivateTabRelative(1), "next tab" },

  ---Window management
  { "<" .. mod .. "-n>", act.SpawnWindow, "new window" },
  { "<" .. mod_alt .. "-f>", act.ToggleFullScreen, "fullscreen" },

  ---Copy / Paste
  { "<" .. mod .. "-c>", act.CopyTo "Clipboard", "copy" },
  { "<" .. mod .. "-v>", act.PasteFrom "Clipboard", "paste" },

  ---Find
  { "<" .. mod .. "-f>", act.Search "CurrentSelectionOrEmptyString", "search" },

  ---Font size (Cmd / Ctrl + =/0, minus handled separately below)
  { "<" .. (is_mac and "W" or "C") .. "-=>", act.IncreaseFontSize, "increase font" },
  { "<" .. (is_mac and "W" or "C") .. "-0>", act.ResetFontSize, "reset font" },

  ---Scrollback
  { "<" .. mod .. "-k>", act.ClearScrollback "ScrollbackOnly", "clear scrollback" },
  { "<PageUp>", act.ScrollByPage(-1), "" },
  { "<PageDown>", act.ScrollByPage(1), "" },

  ---Pane splitting
  { "<" .. mod .. "-d>", act.SplitHorizontal { domain = "CurrentPaneDomain" }, "vsplit" },
  { "<" .. mod2 .. "-d>", act.SplitVertical { domain = "CurrentPaneDomain" }, "hsplit" },

  ---Pane navigation
  { "<" .. mod_alt .. "-h>", act.ActivatePaneDirection "Left", "pane left" },
  { "<" .. mod_alt .. "-j>", act.ActivatePaneDirection "Down", "pane down" },
  { "<" .. mod_alt .. "-k>", act.ActivatePaneDirection "Up", "pane up" },
  { "<" .. mod_alt .. "-l>", act.ActivatePaneDirection "Right", "pane right" },

  ---Zoom pane
  { "<" .. mod2 .. "-CR>", act.TogglePaneZoomState, "toggle zoom" },

  ---Utils
  { "<" .. mod2 .. "-p>", act.ActivateCommandPalette, "command palette" },
  { "<" .. mod2 .. "-l>", act.ShowDebugOverlay, "debug overlay" },
  { "<" .. mod2 .. "-r>", act.ReloadConfiguration, "reload config" },
  { "<" .. mod2 .. "-Space>", act.QuickSelect, "quick select" },
  {
    "<" .. mod .. "-u>",
    act.CharSelect {
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    },
    "char select",
  },

  ---Close pane
  { "<" .. mod2 .. "-w>", act.CloseCurrentPane { confirm = true }, "close pane" },
}

---Tab switching: Cmd+1..9 (macOS) / Ctrl+1..9 (Windows)
local tab_mod = is_mac and "W" or "C"
for i = 1, 9 do
  mappings[#mappings + 1] =
    { "<" .. tab_mod .. "-" .. i .. ">", act.ActivateTab(i - 1), "tab " .. i }
end

Config.keys = {}
for _, map_tbl in ipairs(mappings) do
  key.map(map_tbl[1], map_tbl[2], Config.keys)
end

---Decrease font size — inserted raw because the vim parser
---cannot distinguish the "-" key from the "-" modifier separator.
---  macOS: Cmd+Minus / Windows: Ctrl+Minus
Config.keys[#Config.keys + 1] = {
  key = "-",
  mods = is_mac and "SUPER" or "CTRL",
  action = act.DecreaseFontSize,
}

return Config
