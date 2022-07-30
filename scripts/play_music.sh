# Plays the freetube playlist in mpv

jq -r '"ytdl://\(.[0].videos[].videoId)"' ~/.dotfiles/freetube/playlists.db  | mpv --playlist=- --vid=no --shuffle 