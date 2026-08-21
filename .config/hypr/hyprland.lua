-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Machine-specific config, one file per hostname 
local host_modules = {
  ["rutger-laptop-omarchy"] = "hypr.rutger-laptop-omarchy",
  ["rutger-desktop-omarchy"] = "hypr.rutger-desktop-omarchy",
}

local hostname_handle = io.popen("hostname")
local hostname = hostname_handle and hostname_handle:read("*l") or nil
if hostname_handle then hostname_handle:close() end

local host_module = hostname and host_modules[hostname]
if host_module then
  require(host_module)
end

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Per-app window rules, one file per app (mirrors Omarchy's own apps/ dir).
-- Omarchy's require_all.files() uses `find -type f`, which skips symlinks, so it
-- finds nothing in this stow-managed tree. Same loop, but with `find -L`.
local paths = require("default.hypr.paths")
local rules_dir = paths.config_home .. "/hypr/application-rules"
local rules_handle = io.popen("find -L '" .. rules_dir .. "' -maxdepth 1 -type f -name '*.lua' -printf '%f\\n' | sort")
if rules_handle then
  for filename in rules_handle:lines() do
    require("hypr.application-rules." .. filename:gsub("%.lua$", ""))
  end
  rules_handle:close()
end

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })
