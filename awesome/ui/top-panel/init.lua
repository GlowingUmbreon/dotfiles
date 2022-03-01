local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

configuration = require("configuration.config")
require("widgets.top-panel")

local keyboard_layout = require("keyboard_layoutt")
local kbdcfg = keyboard_layout.kbdcfg({ type = "tui" })

kbdcfg.add_primary_layout("Qwerty", "Q", "")
kbdcfg.add_primary_layout("Colemak", "C", "colemak")

kbdcfg.bind()
kbdcfg.widget:buttons(awful.util.table.join(
	awful.button({}, 1, function()
		kbdcfg.switch_next()
	end),
	awful.button({}, 3, function()
		kbdcfg.menu:toggle()
	end)
))

systray = wibox.widget.systray()
systray.visible = false

local padding = 12
local halfPad = 6

local function AddPad(obj)
	local a = wibox.container.margin(
		obj,
		10,
		10,
		0,
		0
	)
	a.forced_height = configuration.toppanel_height+5
	return wibox.container.background(
		a,
		dracula.transparentBackground
	)
end

date = AddPad(wibox.widget.textclock(" %a %b %d "))
time = AddPad(wibox.widget.textclock(" %H:%M "))

local TopPanel = function(s)
	local panel = wibox({
		ontop = true,
		screen = s,
		height = configuration.toppanel_height+halfPad,
		width = s.geometry.width-padding,
		x = s.geometry.x+halfPad,
		y = s.geometry.y+halfPad,
		bg = beautiful.background,
		fg = beautiful.fg_normal,
	})

	panel:struts({
		top = configuration.toppanel_height+padding,
	})

	panel:setup({
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			AddPad(s.mytaglist),
			--s.mypromptbox,
		},
		{
			layout = wibox.layout.ratio.horizontal,
			wibox.container.place(time, 'center', 'center'),
		},
		{
			layout = wibox.layout.fixed.horizontal,
			systray,
			date,
			kbdcfg
		},
		layout = wibox.layout.align.horizontal,
		
		--s.mytasklist, -- Middle widget
		--s.mylayoutbox,
		--,
		--[[{ -- Right widgets
			--layout = wibox.layout.fixed.horizontal,
			layout = wibox.container.place,
			forced_height = 30,
			valign = "center",
			halign = "center",
			time,
		},]]
	})

	return panel
end

return TopPanel
