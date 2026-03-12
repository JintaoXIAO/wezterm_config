---@module "config.mouse"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local is_win = require("utils.fn").fs.platform().is_win

local Config = {}

---Windows: select-to-copy + right-click-to-paste (PuTTY / Windows Terminal style)
if is_win then
  Config.mouse_bindings = {
    ---releasing left button after a drag selection copies to the system clipboard
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.CompleteSelectionOrOpenLinkAtMouseCursor "Clipboard",
    },
    ---right-click pastes from the system clipboard
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = act.PasteFrom "Clipboard",
    },
  }
end

return Config