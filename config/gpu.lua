local Config = {}

Config.front_end = "WebGpu"
Config.webgpu_force_fallback_adapter = false

---switch to low power mode when battery is low
---@diagnostic disable-next-line: undefined-field
local battery_info = require("wezterm").battery_info()
local battery_charge = battery_info[1] and battery_info[1].state_of_charge or 1.0
if battery_charge < 0.35 then
  Config.webgpu_power_preference = "LowPower"
else
  Config.webgpu_power_preference = "HighPerformance"
end

Config.webgpu_preferred_adapter = require("utils.gpu"):pick_best()

return Config
