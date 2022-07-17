jq -r '"ytdl://\(.[0].videos[].videoId)"' ~/.dotfiles/freetube/playlists.db  | mpv --playlist=- --vid=no --shuffle --input-ipc-server=/tmp/mpvsocket

termux-notification
    --type 'media'
    --media-next $'echo \'{"command": ["playlist-next"]}\' > /tmp/mpvsocket'
    --media-pause $'echo \'{"command": ["cycle", "pause"]}\' > /tmp/mpvsocket'
    --media-play $'echo \'{"command": ["cycle", "pause"]}\' > /tmp/mpvsocket'
    --media-previous $'echo \'{"command": ["playlist-prev"]}\' > /tmp/mpvsocket'