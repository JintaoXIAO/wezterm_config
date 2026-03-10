---@module "mappings.modes"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local key = require("utils.fn").key

local Config = {}

local key_tables = {
  -- {{{1 COPY MODE (copy_mode)
  copy_mode = {
    { "<ESC>", act.CopyMode "Close", "exit" },
    {
      "y",
      act.Multiple {
        { CopyTo = "ClipboardAndPrimarySelection" },
        { CopyMode = "Close" },
      },
      "copy selection",
    },
    { "h", act.CopyMode "MoveLeft", "left" },
    { "j", act.CopyMode "MoveDown", "up" },
    { "k", act.CopyMode "MoveUp", "down" },
    { "l", act.CopyMode "MoveRight", "right" },
    { "b", act.CopyMode "MoveBackwardWord", "word backward" },
    { "e", act.CopyMode "MoveForwardWordEnd", "word end" },
    { "w", act.CopyMode "MoveForwardWord", "word forward" },
    { "<Tab>", act.CopyMode "MoveForwardWord", "forward" },
    { "<S-Tab>", act.CopyMode "MoveBackwardWord", "backward" },
    { "<CR>", act.CopyMode "MoveToStartOfNextLine", "next line" },
    { "<Space>", act.CopyMode { SetSelectionMode = "Cell" }, "" },
    { "0", act.CopyMode "MoveToStartOfLine", "line start" },
    { "<S-$>", act.CopyMode "MoveToEndOfLineContent", "line end" },
    { "^", act.CopyMode "MoveToStartOfLineContent", "" },
    { ",", act.CopyMode "JumpReverse", "repeat back" },
    { ";", act.CopyMode "JumpAgain", "repeat" },
    { "F", act.CopyMode { JumpBackward = { prev_char = false } }, "" },
    { "f", act.CopyMode { JumpForward = { prev_char = false } }, "" },
    { "T", act.CopyMode { JumpBackward = { prev_char = true } }, "" },
    { "t", act.CopyMode { JumpForward = { prev_char = true } }, "" },
    { "G", act.CopyMode "MoveToScrollbackBottom", "bot" },
    { "g", act.CopyMode "MoveToScrollbackTop", "top" },
    { "H", act.CopyMode "MoveToViewportTop", "viewport top" },
    { "M", act.CopyMode "MoveToViewportMiddle", "viewport middle" },
    { "L", act.CopyMode "MoveToViewportBottom", "viewport bot" },
    { "V", act.CopyMode { SetSelectionMode = "Line" }, "line mode" },
    { "v", act.CopyMode { SetSelectionMode = "Cell" }, "cell mode" },
    { "<C-v>", act.CopyMode { SetSelectionMode = "Block" }, "block mode" },
    { "O", act.CopyMode "MoveToSelectionOtherEndHoriz", "selection other end" },
    { "o", act.CopyMode "MoveToSelectionOtherEnd", "selection end" },
    { "<C-d>", act.CopyMode { MoveByPage = 0.5 }, "scroll down" },
    { "<C-u>", act.CopyMode { MoveByPage = -0.5 }, "scroll up" },
  }, -- }}}

  -- {{{1 SEARCH MODE (search_mode)
  search_mode = {
    { "<ESC>", act.CopyMode "Close", "exit" },
    { "<C-n>", act.CopyMode "NextMatch", "next" },
    { "<C-N>", act.CopyMode "PriorMatch", "prev" },
    { "<C-r>", act.CopyMode "CycleMatchType", "cycle type" },
    { "<C-u>", act.CopyMode "ClearPattern", "clear pattern" },
    { "<PageUp>", act.CopyMode "PriorMatchPage", "prev page" },
    { "<PageDown>", act.CopyMode "NextMatchPage", "next page" },
    { "<UpArrow>", act.CopyMode "PriorMatch", "next" },
    { "<DownArrow>", act.CopyMode "NextMatch", "prev" },
  }, -- }}}
}

Config.key_tables = {}
for mode, mode_table in pairs(key_tables) do
  Config.key_tables[mode] = {}
  for _, map_tbl in ipairs(mode_table) do
    key.map(map_tbl[1], map_tbl[2], Config.key_tables[mode])
  end
end

return { Config, key_tables }
