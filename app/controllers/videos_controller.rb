class VideosController < ApplicationController
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
    @video = Video.new(params[:video])
    
    if @video.save
      @video.pl_additions.create(playlist_id: params[:video][:playlist_id])
      respond_to do |format|
        format.html { render 'show' }
        format.js
      end
    else
      #should flash an error without leaving the page.
      #for now just redirect.
      flash[:error] = "Invalid video URL."
      render 'show'
    end
  end
end
