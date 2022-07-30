# Used to make splitscreen

gap=$(bspc config window_gap)
if [ $gap -eq 0 ]; then
	bspc config window_gap 12
	bspc config border_width 2
else
	bspc config window_gap 0
	bspc config border_width 1
fi