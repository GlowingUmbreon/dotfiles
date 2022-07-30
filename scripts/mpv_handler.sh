#!/bin/bash
# In about:config set network.protocol-handler.expose.mpv to false
# When you next open up a mpv link it will ask for a program, choose this script.

url=`echo "$1" | cut -c 7-`
mpv --player-operation-mode=pseudo-gui --fullscreen "$url"s