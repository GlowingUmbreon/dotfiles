BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "android_metadata" (
	"locale"	TEXT
);
CREATE TABLE IF NOT EXISTS "subscriptions" (
	"uid"	INTEGER NOT NULL,
	"service_id"	INTEGER NOT NULL,
	"url"	TEXT,
	"name"	TEXT,
	"avatar_url"	TEXT,
	"subscriber_count"	INTEGER,
	"description"	TEXT,
	"notification_mode"	INTEGER NOT NULL,
	PRIMARY KEY("uid" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "search_history" (
	"creation_date"	INTEGER,
	"service_id"	INTEGER NOT NULL,
	"search"	TEXT,
	"id"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "streams" (
	"uid"	INTEGER NOT NULL,
	"service_id"	INTEGER NOT NULL,
	"url"	TEXT NOT NULL,
	"title"	TEXT NOT NULL,
	"stream_type"	TEXT NOT NULL,
	"duration"	INTEGER NOT NULL,
	"uploader"	TEXT NOT NULL,
	"uploader_url"	TEXT,
	"thumbnail_url"	TEXT,
	"view_count"	INTEGER,
	"textual_upload_date"	TEXT,
	"upload_date"	INTEGER,
	"is_upload_date_approximation"	INTEGER,
	PRIMARY KEY("uid" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "stream_history" (
	"stream_id"	INTEGER NOT NULL,
	"access_date"	INTEGER NOT NULL,
	"repeat_count"	INTEGER NOT NULL,
	PRIMARY KEY("stream_id","access_date"),
	FOREIGN KEY("stream_id") REFERENCES "streams"("uid") ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "stream_state" (
	"stream_id"	INTEGER NOT NULL,
	"progress_time"	INTEGER NOT NULL,
	PRIMARY KEY("stream_id"),
	FOREIGN KEY("stream_id") REFERENCES "streams"("uid") ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "playlists" (
	"uid"	INTEGER NOT NULL,
	"name"	TEXT,
	"thumbnail_url"	TEXT,
	PRIMARY KEY("uid" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "playlist_stream_join" (
	"playlist_id"	INTEGER NOT NULL,
	"stream_id"	INTEGER NOT NULL,
	"join_index"	INTEGER NOT NULL,
	PRIMARY KEY("playlist_id","join_index"),
	FOREIGN KEY("playlist_id") REFERENCES "playlists"("uid") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("stream_id") REFERENCES "streams"("uid") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "remote_playlists" (
	"uid"	INTEGER NOT NULL,
	"service_id"	INTEGER NOT NULL,
	"name"	TEXT,
	"url"	TEXT,
	"thumbnail_url"	TEXT,
	"uploader"	TEXT,
	"stream_count"	INTEGER,
	PRIMARY KEY("uid" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "feed" (
	"stream_id"	INTEGER NOT NULL,
	"subscription_id"	INTEGER NOT NULL,
	FOREIGN KEY("subscription_id") REFERENCES "subscriptions"("uid") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("stream_id","subscription_id"),
	FOREIGN KEY("stream_id") REFERENCES "streams"("uid") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "feed_group" (
	"uid"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	"icon_id"	INTEGER NOT NULL,
	"sort_order"	INTEGER NOT NULL,
	PRIMARY KEY("uid" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "feed_group_subscription_join" (
	"group_id"	INTEGER NOT NULL,
	"subscription_id"	INTEGER NOT NULL,
	PRIMARY KEY("group_id","subscription_id"),
	FOREIGN KEY("group_id") REFERENCES "feed_group"("uid") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("subscription_id") REFERENCES "subscriptions"("uid") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "feed_last_updated" (
	"subscription_id"	INTEGER NOT NULL,
	"last_updated"	INTEGER,
	FOREIGN KEY("subscription_id") REFERENCES "subscriptions"("uid") ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("subscription_id")
);
CREATE TABLE IF NOT EXISTS "room_master_table" (
	"id"	INTEGER,
	"identity_hash"	TEXT,
	PRIMARY KEY("id")
);
CREATE UNIQUE INDEX IF NOT EXISTS "index_subscriptions_service_id_url" ON "subscriptions" (
	"service_id",
	"url"
);
CREATE INDEX IF NOT EXISTS "index_search_history_search" ON "search_history" (
	"search"
);
CREATE UNIQUE INDEX IF NOT EXISTS "index_streams_service_id_url" ON "streams" (
	"service_id",
	"url"
);
CREATE INDEX IF NOT EXISTS "index_stream_history_stream_id" ON "stream_history" (
	"stream_id"
);
CREATE INDEX IF NOT EXISTS "index_playlists_name" ON "playlists" (
	"name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "index_playlist_stream_join_playlist_id_join_index" ON "playlist_stream_join" (
	"playlist_id",
	"join_index"
);
CREATE INDEX IF NOT EXISTS "index_playlist_stream_join_stream_id" ON "playlist_stream_join" (
	"stream_id"
);
CREATE INDEX IF NOT EXISTS "index_remote_playlists_name" ON "remote_playlists" (
	"name"
);
CREATE UNIQUE INDEX IF NOT EXISTS "index_remote_playlists_service_id_url" ON "remote_playlists" (
	"service_id",
	"url"
);
CREATE INDEX IF NOT EXISTS "index_feed_subscription_id" ON "feed" (
	"subscription_id"
);
CREATE INDEX IF NOT EXISTS "index_feed_group_sort_order" ON "feed_group" (
	"sort_order"
);
CREATE INDEX IF NOT EXISTS "index_feed_group_subscription_join_subscription_id" ON "feed_group_subscription_join" (
	"subscription_id"
);
COMMIT;
