function fish_greeting
	# Display a neofetch prompt if you are not in a tty
	if not status is-login
		fastfetch --color-1 blue -c blue
	end
end
