Playlister
=============
http://playlister.herokuapp.com

A web application to create anonymous or private collaborative YouTube playlists.

The application uses:
* a Faye (via Private_Pub) instance for pub/sub of playlist updates.
* iframe YouTube API for html5 fallback.
* OAuth2 and youtube_it gem for Playlist uploads.
