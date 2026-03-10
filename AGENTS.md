# AGENTS.md - Wezterm Configuration

## Project Overview

This is a **Lua-based WezTerm terminal emulator configuration** by sravioli.
It is NOT a compiled application -- it is a set of Lua modules loaded by WezTerm at
runtime. The entry point is `wezterm.lua`. All code is Lua 5.1+ (WezTerm's embedded
Lua interpreter).

## Repository Structure

```
wezterm.lua              -- Entry point: builds Config, loads events and mappings
config/                  -- WezTerm configuration tables (appearance, font, gpu, tab-bar, general)
  init.lua               -- Merges all config submodules
events/                  -- WezTerm event handlers (update-status, format-tab-title, etc.)
mappings/                -- Keybinding definitions (default keys and modal key tables)
  init.lua               -- Merges default + modes
picker/                  -- Interactive pickers (colorscheme, font, font-size, font-leading)
  assets/                -- Data files for pickers (colorschemes/, fonts/, font-sizes/, etc.)
utils/                   -- Utility library
  fn.lua                 -- Core functions: table, filesystem, keymap, math, string, color
  gpu.lua                -- GPU adapter selection
  init.lua               -- Lazy-loading module index
  class/                 -- OOP-style classes (config, layout, logger, picker, icon)
  external/              -- Third-party vendored code (inspect.lua)
```

## Build / Lint / Test Commands

There is **no build step** -- WezTerm loads Lua files directly. There is no test suite.

### Formatting

The project uses **StyLua** for Lua formatting. Configuration is in `.stylua.toml`.

```sh
# Format all Lua files
stylua .

# Format a single file
stylua path/to/file.lua

# Check formatting without writing
stylua --check .
```

### Linting

The project uses **selene** for linting (evidenced by `selene: allow(...)` annotations).

```sh
# Lint all files
selene .

# Lint a single file
selene path/to/file.lua
```

### Versioning / Releases

The project uses **cocogitto** (`cog`) for conventional commits and SemVer releases.
Configuration is in `cog.toml`. Commits must follow [Conventional Commits](https://www.conventionalcommits.org/).

```sh
# Verify commits
cog check

# Bump version
cog bump --auto
```

## Code Style Guidelines

### Formatting Rules (from `.stylua.toml`)

- **Indent**: 2 spaces (no tabs)
- **Column width**: 90 characters (soft limit)
- **Line endings**: Unix (LF)
- **Quotes**: Double quotes preferred (`AutoPreferDouble`)
- **Call parentheses**: `None` -- omit parens on single-string and single-table arguments
  - `require "wezterm"` not `require("wezterm")` for single strings
  - `wt.font_with_fallback { ... }` not `wt.font_with_fallback({ ... })`
  - Use parentheses when there are multiple arguments or when clarity requires it
- **Require sorting**: Enabled -- consecutive `local X = require(...)` blocks are sorted

### Module Header

Every module file should start with these annotations:

```lua
---@module "module.path"
---@author sravioli
---@license GNU-GPLv3
```

### Imports / Requires

- Alias `require "wezterm"` as `local wt = require "wezterm"` (consistently use `wt`)
- For performance, cache globals as locals at the top of the file:
  ```lua
  local pairs, require, tonumber, tostring, type = pairs, require, tonumber, tostring, type
  local sfind, sformat, sgsub, smatch = string.find, string.format, string.gsub, string.match
  ```
- Use abbreviated prefixes for standard library caching:
  - `s` for `string` (`sfind`, `sformat`, `sgsub`, `smatch`, `ssub`, `srep`, `schar`)
  - `t` for `table` (`tconcat`, `tremove`, `tinsert`, `tunpack`)
  - `m` for `math` (`mceil`, `mfloor`)
  - `io` for `io` (`ioopen`, `ioclose`)
  - `o` for `os` (`oexec`, `ogetenv`)
- Import project utilities via:
  ```lua
  local Utils = require "utils"
  local fn = Utils.fn
  local class = Utils.class
  ```

### Naming Conventions

- **Modules**: Return a table, typically `local M = {}` ... `return M`
- **Classes**: PascalCase for class names in annotations (`Utils.Class.Config`, `Utils.Fn.Table`)
- **Sub-namespaces**: Use short lowercase names on the module table (`M.fs`, `M.tbl`, `M.str`, `M.mt`, `M.key`, `M.color`, `M.g`)
- **Functions**: `snake_case` for public functions (`M.fs.find_git_dir`, `M.str.format_tab_title`)
- **Private/package functions**: Prefix with double underscore (`M.key.__check`, `M.key.__has`)
- **Local helpers**: Use a `local h = {}` table for file-scoped helper functions
- **Config tables**: Use `local Config = {}` pattern, set keys directly (`Config.font_size = 10.5`), then `return Config`
- **Constants/icons**: PascalCase for icon table keys (`M.Progs`, `M.Nums`, `M.Sep`, `M.Bat`)

### Type Annotations

- Use LuaLS (lua-language-server) `---@` annotations extensively
- Annotate classes: `---@class Utils.Class.Config`
- Annotate function params and returns: `---@param`, `---@return`
- Annotate fields: `---@field`
- Use `---@package` for internal/private members
- Use `---@diagnostic disable-line:` or `---@diagnostic disable-next-line:` to suppress known false positives from WezTerm's API
- Use `---@alias` for complex type shorthand

### Documentation

- Write LuaDoc comments (`---`) for all public functions with:
  - Description paragraph
  - `@param` and `@return` tags
  - `@usage` or inline `~~~lua ... ~~~` code examples where helpful
- Use vim fold markers (`-- {{{1`, `-- }}}`, `--~ {{{2`, `--~~ {{{3`) to organize large files into collapsible sections

### Error Handling

- Use the `Logger` class for all logging: `require("utils.class.logger"):new "ClassName"`
- Logger supports levels: `debug`, `info`, `warn`, `error`
- Log messages use format strings with `%s` placeholders (the logger auto-stringifies args)
- Use `pcall` for fallible `require` calls (see `Config:add()` in `utils/class/config.lua`)
- Return `nil` from functions to signal failure, log the error via the logger
- Use `selene: allow(...)` comments to suppress specific lint warnings

### Memoization / Caching

- Use `wezterm.GLOBAL.cache` for memoizing expensive computations via `M.g.memoize(key, value)`
- Cache file reads, platform detection, path computations, etc.
- Memoized functions can be cleared with `M.g.forget(key)`

### Keymapping Pattern

- Keymaps use vim-like syntax strings: `"<C-S-t>"`, `"<leader>w"`, `"<M-CR>"`
- Map via `key.map(lhs, rhs, tbl)` which parses the string and inserts into the table
- Key tables are defined as arrays of `{ lhs, action, description }` triples

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- Format: `type(scope): description`
- Types: `feat`, `fix`, `refactor`, `chore`, `hotfix`, `release`, `docs`, `style`, `test`
- Scope is optional, use module path like `utils:fn`, `utils:class`, `config`, `events`
- Example: `fix(utils:fn): rename fs.read_dir() to fs.ls_dir()`
