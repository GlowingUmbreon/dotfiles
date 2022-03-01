local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")

require("awful.autofocus")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local superKey = require("configuration.keys.mod").superKey
local altkey = require("configuration.keys.mod").altKey
local apps = require("configuration.apps")

-- {{{ Key bindings
globalKeys = gears.table.join(
	awful.key({ superKey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ superKey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ superKey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),

	awful.key({ superKey, "Shift" }, "Left", function()
		-- get current tag
		local t = client.focus and client.focus.first_tag or nil
		if t == nil then
			return
		end
		-- get previous tag (modulo 9 excluding 0 to wrap from 1 to 9)
		local tag = client.focus.screen.tags[(t.index - 2) % 9 + 1]
		awful.client.movetotag(tag)
		awful.tag.viewprev()
	end, { description = "move client to previous tag and switch to it", group = "tag" }),

	awful.key({ superKey, "Shift" }, "Right", function()
		-- get current tag
		local t = client.focus and client.focus.first_tag or nil
		if t == nil then
			return
		end
		-- get next tag (modulo 9 excluding 0 to wrap from 9 to 1)
		local tag = client.focus.screen.tags[(t.index % 9) + 1]
		awful.client.movetotag(tag)
		awful.tag.viewnext()
	end, { description = "move client to next tag and switch to it", group = "tag" }),

	awful.key({ superKey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ superKey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ superKey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ superKey }, "w", function()
		systray.visible = not systray.visible
	end, { description = "Toggle systray", group = "awesome" }),

	-- Layout manipulation
	awful.key({ superKey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ superKey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ superKey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ superKey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key(
		{ superKey },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }
	),
	awful.key({ superKey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ superKey }, "Return", function()
		awful.spawn(apps.terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ superKey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ superKey, "Shift" }, "e", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ "Control", "Mod1" }, "Delete", function()
		--awful.spawn("systemctl suspend")
		awful.spawn("rofi -show p -modi p:rofi-power-menu -theme power")
	end, { description = "suspend", group = "awesome" }),

	awful.key({ superKey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ superKey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ superKey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ superKey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ superKey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ superKey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ superKey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ superKey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ superKey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	awful.key({ superKey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),

	awful.key({ superKey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	-- Menubar
	awful.key({ superKey }, "p", function()
		--menubar.show()
		awful.util.spawn("rofi -show run -theme main")
	end, { description = "show the menubar", group = "launcher" }),

	-- Screenshot
	awful.key({}, "Print", function()
		awful.util.spawn("escrotum -C")
	end, { description = "Take a screenshot", group = "screenshot"}),

	awful.key({ superKey }, "Print", function()
		awful.util.spawn("escrotum -C -s")
	end, { description = "Take a screenshot", group = "screenshot"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (super+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = { description = "view tag #", group = "tag" }
		descr_toggle = { description = "toggle tag #", group = "tag" }
		descr_move = { description = "move focused client to tag #", group = "tag" }
		descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
	end
	globalKeys = awful.util.table.join(
		globalKeys,
		-- View tag only.
		awful.key({ superKey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, descr_view),
		-- Toggle tag display.
		awful.key({ superKey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, descr_toggle),
		-- Move client to tag.
		awful.key({ superKey, "Shift" }, "#" .. i + 9, function()
			if _G.client.focus then
				local tag = _G.client.focus.screen.tags[i]
				if tag then
					_G.client.focus:move_to_tag(tag)
				end
			end
		end, descr_move),
		-- Toggle tag on focused client.
		awful.key({ superKey, "Control", "Shift" }, "#" .. i + 9, function()
			if _G.client.focus then
				local tag = _G.client.focus.screen.tags[i]
				if tag then
					_G.client.focus:toggle_tag(tag)
				end
			end
		end, descr_toggle_focus)
	)
end

return globalKeys
