# WezTerm Configuration

A cross-platform [WezTerm](https://wezfurlong.org/wezterm/) configuration designed to feel like macOS Terminal, with a **Grass** green color scheme and native-style UI.

## Features

- **Grass colorscheme** — rich green background inspired by macOS Terminal's Grass profile
- **Browser-style tabs** — integrated title buttons, tabs at the top edge (no separate title bar)
- **Native fancy tab bar** with platform-appropriate window controls
- **Cross-platform keybindings** — Cmd-based on macOS, Ctrl+Shift-based on Windows
- **Platform-aware defaults** — Menlo font on macOS, Consolas on Windows; zsh on macOS, PowerShell on Windows
- **Minimal status bar** — clean tab titles showing `process — directory`

## Keybindings

| Action              | macOS              | Windows              |
|---------------------|--------------------|----------------------|
| Quit                | `Cmd+Q`            | `Ctrl+Shift+Q`       |
| New tab             | `Cmd+T`            | `Ctrl+Shift+T`       |
| Close tab           | `Cmd+W`            | `Ctrl+Shift+W`       |
| Prev / Next tab     | `Cmd+Shift+[ / ]`  | `Ctrl+Alt+[ / ]`     |
| Switch to tab 1-9   | `Cmd+1-9`          | `Ctrl+1-9`           |
| Copy / Paste        | `Cmd+C / V`        | `Ctrl+Shift+C / V`   |
| Find                | `Cmd+F`            | `Ctrl+Shift+F`       |
| Font size +/-/reset | `Cmd+= / - / 0`    | `Ctrl+= / - / 0`     |
| Split horizontal    | `Cmd+D`            | `Ctrl+Shift+D`       |
| Split vertical      | `Cmd+Shift+D`      | `Ctrl+Alt+D`         |
| Pane navigation     | `Cmd+Alt+H/J/K/L`  | `Alt+Shift+H/J/K/L`  |
| Command palette     | `Cmd+Shift+P`      | `Ctrl+Alt+P`         |
| Reload config       | `Cmd+Shift+R`      | `Ctrl+Alt+R`         |

## Structure

```
wezterm.lua              Entry point
config/
  init.lua               Merges all config submodules
  appearance.lua         Colors, cursor, window chrome
  font.lua               Font (Menlo / Consolas), font rules
  tab-bar.lua            Tab bar settings
  general.lua            Shell, launch menu
  gpu.lua                GPU adapter selection
events/
  update-status.lua      Status bar (minimal)
  format-tab-title.lua   Tab title formatting
  format-window-title.lua  Window title formatting
  new-tab-button-click.lua  New tab button behavior
  augment-command-palette.lua  Extra palette commands
mappings/
  init.lua               Merges default + modes
  default.lua            Platform-aware keybindings
  modes.lua              Copy mode, search mode
picker/
  colorscheme.lua        Colorscheme picker
  font.lua               Font picker
  font-size.lua          Font size picker
  font-leading.lua       Line height picker
  assets/                Data files (colorschemes, fonts, etc.)
utils/
  init.lua               Lazy-loading module index
  fn.lua                 Core utilities (fs, string, table, color, keymap)
  gpu.lua                GPU adapter selection
  class/                 OOP classes (config, layout, logger, picker, icon)
```

## Requirements

- [WezTerm](https://wezfurlong.org/wezterm/) (tested with 20240203+)
- On macOS: Menlo font (built-in)
- On Windows: Consolas font (built-in)

## Installation

Clone into WezTerm's config directory:

```sh
# macOS / Linux
git clone <repo-url> ~/.config/wezterm

# Windows (PowerShell)
git clone <repo-url> $HOME/.config/wezterm
```

> **Note**: If a `~/.wezterm.lua` file exists, it takes priority over `~/.config/wezterm/wezterm.lua`. Remove or rename it to use this configuration.

## Formatting & Linting

```sh
stylua .           # format all Lua files
stylua --check .   # check without writing
selene .           # lint all files
```
