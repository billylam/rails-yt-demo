class YoutubeUploadsController < ApplicationController
  def create
    if session[:refresh_token]
      client = YouTubeIt::OAuth2Client.new(
        client_access_token: session[:access_token], 
        client_refresh_token: session[:refresh_token],
        client_id: ENV["YT_CLIENT_ID"], 
        client_secret: ENV["YT_CLIENT_SECRET"], 
        dev_key: ENV["YT_DEV_KEY"]) 

      playlist = Playlist.find(params[:playlist_id])

      #check to see if access_token is still valid
      #do this because checking via expiration time can be spotty
      response_body = JSON.parse client.session_token_info[:body]
      if response_body["error"] == "invalid_token"
        response = client.refresh_access_token!
        session[:access_token] = response.token
      end

      #youtube playlists are created by looping add video requests 1 at a time
      yt_playlist = client.add_playlist(title: playlist.name, description: "Created by playlister.herokuapp.com")
      yt_playlist_id = yt_playlist.playlist_id
      playlist.videos.each do |video|
        client.add_video_to_playlist(yt_playlist_id, video.youtube_id)
      end
      #in the future should do this asynchronously
      redirect_to "https://www.youtube.com/playlist?list=#{yt_playlist_id}"
    else
      redirect_to "https://accounts.google.com/o/oauth2/auth?client_id=940183026987.apps.googleusercontent.com&redirect_uri=#{root_url}callback&scope=https://gdata.youtube.com&response_type=code&approval_prompt=force&access_type=offline"
    end
  end

  def callback
    result = request_tokens(params[:code])
    json = JSON.parse result.body

    access_token = json["access_token"]
    session[:access_token] = access_token
    refresh_token = json["refresh_token"]
    session[:refresh_token] = refresh_token

    redirect_to root_url
  end

  def request_tokens(code)
    conn = Faraday.new(url: 'https://accounts.google.com', ssl: {verify: false}) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end

    result = conn.post '/o/oauth2/token', {'code' => code,
      'client_id' => ENV["YT_CLIENT_ID"], 
      'client_secret' => ENV["YT_CLIENT_SECRET"], 
      'redirect_uri' => callback_url,
      'grant_type' => 'authorization_code'}
  end
end
