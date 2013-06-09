class VideosController < ApplicationController
  include VideosHelper
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @videos }
    end
  end

  # POST /videos
  # POST /videos.json
  def create
    @playlist = Playlist.find(params[:video][:playlist_id])
    @video = Video.new(params[:video])

    #if the video is already in db, create a pl_addition link and format.js 
    youtube_id = parse_youtube_id(params[:video][:url_raw])
    if !Video.find_by_youtube_id(youtube_id).nil?
      @video = Video.find_by_youtube_id(youtube_id)
      @video.pl_additions.create(playlist_id: @playlist.id) 
      flash[:notice] = "A user added #{@video.name} to playlist!"
    elsif @video.save
      @video.pl_additions.create(playlist_id: @playlist.id) 
      flash[:notice] = "A user added #{@video.name} to playlist!"
    else
      @video = nil
      flash[:error] = "Invalid video URL."
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end
end
