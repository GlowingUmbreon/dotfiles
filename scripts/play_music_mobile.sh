termux-notification \
    --type 'media' \
    --alert-once \
    --media-next $'echo \'{"command": ["playlist-next"]}\' | socat - ~/mpvsocket' \
    --media-pause $'echo \'{"command": ["cycle", "pause"]}\' | socat - ~/mpvsocket' \
    --media-play $'echo \'{"command": ["cycle", "pause"]}\' | socat - ~/mpvsocket' \
    --media-previous $'echo \'{"command": ["playlist-prev"]}\' | socat - ~/mpvsocket'
jq -r '"ytdl://\(.[0].videos[].videoId)"' ~/.dotfiles/freetube/playlists.db  | mpv --playlist=- --vid=no --shuffle --input-ipc-server=~/mpvsocket