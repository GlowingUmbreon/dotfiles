function music --wraps='mpv "https://www.youtube.com/playlist?list=LL" --no-video --ytdl-raw-options-add="cookies-from-browser=firefox" --shuffle' --description 'alias music=mpv "https://www.youtube.com/playlist?list=LL" --no-video --ytdl-raw-options-add="cookies-from-browser=firefox" --shuffle'
  mpv "https://www.youtube.com/playlist?list=LL" --no-video --ytdl-raw-options-add="cookies-from-browser=firefox" --shuffle $argv; 
end
