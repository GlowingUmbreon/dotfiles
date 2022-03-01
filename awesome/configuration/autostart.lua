local apps = require("configuration.apps")
local filesystem = require("gears.filesystem")

-- List of apps to start once on start-up
return {
	run_on_start_up = {
		"picom",
		"nm-applet --indicator", -- wifi
		-- "xfce4-power-manager", -- Power manager

		-- Add applications that need to be killed between reloads
		-- to avoid multipled instances, inside the awspawn script
		"~/.config/awesome/configuration/autostartonce.sh", -- Spawn "dirty" apps that can linger between sessions
	},
}
