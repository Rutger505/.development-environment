-- Host-specific setup for rutger-cheapcargo-laptop-omarchy.
-- Ported from the old custom-rutger-cheapcargo-laptop-omarchy.conf.

hl.on("hyprland.start", function()
  hl.exec_cmd("[workspace 1 silent] uwsm app -- zen-browser")
  hl.exec_cmd("[workspace 2 silent] uwsm app -- phpstorm")
  hl.exec_cmd("[workspace 3 silent] uwsm app -- ghostty")
  hl.exec_cmd("[workspace 4 silent] uwsm app -- slack")
  hl.exec_cmd("[workspace 5 silent] uwsm app -- spotify")
end)
