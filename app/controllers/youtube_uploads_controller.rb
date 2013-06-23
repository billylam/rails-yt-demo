class YoutubeUploadsController < ApplicationController
  def create
    if session[:access_token]
      #initialize client
      client = YouTubeIt::OAuth2Client.new(client_access_token: session[:access_token], client_id: ENV["YT_CLIENT_ID"], client_secret: ENV["YT_CLIENT_SECRET"], dev_key: ENV["YT_DEV_KEY"]) 
      #create playlist
      
      playlist = Playlist.find(params[:playlist_id])
      yt_playlist = client.add_playlist(title: playlist.name, description: "Created by playlister.herokuapp.com")
      yt_playlist_id = yt_playlist.playlist_id
      #loop through videos
      playlist.videos.each do |video|
        client.add_video_to_playlist(yt_playlist_id, video.youtube_id)
      end

      redirect_to "https://www.youtube.com/playlist?list=#{yt_playlist_id}"
    else
      session[:playlist_id] = params[:playlist_id]
      session[:redirect] = request.referer
      redirect_to "https://accounts.google.com/o/oauth2/auth?client_id=940183026987.apps.googleusercontent.com&redirect_uri=http://playlister.herokuapp.com/callback&scope=https://gdata.youtube.com&response_type=code&approval_prompt=force&access_type=offline"
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
