rails-yt-demo
=============
http://playlister.herokuapp.com

A web application to create anonymous collaborative YouTube playlists.

The application uses a Faye (via Private_Pub) instance for pub/sub of playlist updates.  The Faye server is hosted separately to simplify Heroku setup.

The application uses the YouTube API for html5 fallback.
