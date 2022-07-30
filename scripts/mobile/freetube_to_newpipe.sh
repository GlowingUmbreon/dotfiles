# Converts freetube database to newpipe database

cd ~/.dotfiles/generated
rm newpipe.db

# create database
sqlite3 newpipe.db < ~/.dotfiles/scripts/mobile/freetube_to_newpipe_schema.sql

# playlists
echo '"playlist_id","name","thumbnail_url"' > playlists.csv
echo '1,"Liked Videos",""' >> playlists.csv
sqlite3 newpipe.db ".import --csv -v playlists.csv playlists"

# streams
echo '"uid","service_id","url","title","stream_type","duration","uploader","uploader_url","thumbnail_url","view_count","textual_upload_date","upload_date","is_upload_date_approximation"' > streams.csv
jq -r '.[0].videos | reverse | to_entries | .[] | .value+{key:.key} | [.key+1,0,"https://www.youtube.com/watch?v="+.videoId,.title,"VIDEO_STREAM",.lengthSeconds,.author,"https://www.youtube.com/channel/"+.authorId,"",.viewCount,"",.timeAdded,1] | @csv' ~/.dotfiles/freetube/playlists.db >> streams.csv
sqlite3 newpipe.db ".import --csv -v streams.csv streams"

# playlist_stream_join
echo '"playlist_id","stream_id","join_index"' > playlist_stream_join.csv
jq -r '.[0].videos | to_entries | .[] | [1,.key+1,.key+1] | @csv' ~/.dotfiles/freetube/playlists.db >> playlist_stream_join.csv
sqlite3 newpipe.db ".import --csv -v playlist_stream_join.csv playlist_stream_join"

# subscriptions
echo '"uid","service_id","url","name","avatar_url","subscriber_count","description","notification_mode"' > subscriptions.csv
jq -r '.subscriptions | to_entries | .[] | .value+{key:.key} | [.key+1,0,"https://www.youtube.com/channel/"+.id,.name,.thumbnail,0,"",0] | @csv' ~/.dotfiles/freetube/subscriptions.db >> subscriptions.csv
sqlite3 newpipe.db ".import --csv -v subscriptions.csv subscriptions"

# Compress the file
zip newpipe.zip newpipe.db

# Delete temporary files
rm newpipe.db playlist_stream_join.csv playlists.csv streams.csv subscriptions.csv