#!/bin/bash
# In about:config set network.protocol-handler.expose.mpv to false

url=`echo "$1" | cut -c 7-`
mpv --player-operation-mode=pseudo-gui --fullscreen "$url"s