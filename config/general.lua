local fs = require("utils.fn").fs

local Config = {}

---platform-specific default shell
if fs.platform().is_mac then
  Config.default_prog = { "/bin/zsh", "-l" }
elseif fs.platform().is_win then
  Config.default_prog =
    { "pwsh", "-NoLogo", "-ExecutionPolicy", "RemoteSigned", "-NoProfileLoadTime" }
  Config.launch_menu = {
    { label = "PowerShell V7", args = { "pwsh", "-NoLogo" }, cwd = "~" },
    { label = "PowerShell V5", args = { "powershell" }, cwd = "~" },
    { label = "Command Prompt", args = { "cmd.exe" }, cwd = "~" },
  }
end

Config.default_cwd = fs.home()

-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
Config.ssh_domains = {}

-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
Config.unix_domains = {}

return Config
