local fs = require("utils.fn").fs

local Config = {}

---platform-specific default shell
if fs.platform().is_mac then
  Config.default_prog = { "/bin/zsh", "-l" }
elseif fs.platform().is_win then
  ---Inject OSC 7 (CWD reporting) into PowerShell's prompt so that
  ---WezTerm's right-side status bar updates correctly on `cd`.
  ---  1. Source $PROFILE first so any user customisation is preserved
  ---  2. Wrap the resulting $prompt function to prepend an OSC 7 escape
  ---     sequence on every new prompt (reports CWD to WezTerm)
  -- stylua: ignore
  local ps_osc7 = [[if (Test-Path $PROFILE) { . $PROFILE }; $__p = $function:prompt; function global:prompt { $loc = $ExecutionContext.SessionState.Path.CurrentLocation; [Console]::Write([char]27 + ']7;file://' + $env:COMPUTERNAME + '/' + ($loc.Path -replace '\\', '/') + [char]7); if ($null -ne $__p) { & $__p } else { "PS $loc> " } }]]
  Config.default_prog = {
    "pwsh", "-NoLogo", "-NoExit", "-ExecutionPolicy", "RemoteSigned", "-Command", ps_osc7,
  }
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
