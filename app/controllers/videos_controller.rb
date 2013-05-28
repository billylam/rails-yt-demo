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

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = Video.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new
    #1. parse youtube_id
    id = get_youtube_id(params[:video][:url]) #can remove url from model
    #2. determine if id is valid with call to http://gdata.youtube.com/feeds/   api/videos/#{youtube_id} 
    #  and it is not blank
    rating = get_rating(id)
    #3. parse rating and category if valid
    
    @video.update_attributes(:url => id, :rating => rating)
    if @video.save
      render 'show'
    else
      render 'new'
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

  private
  def get_youtube_id(url)
    if url[/youtu\.be\/([^\?]*)/]
      id = $1
    else
      url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      id = $5
    end
  end

  def get_rating(id)
    require 'open-uri'
    xml = Nokogiri::XML(open("http://gdata.youtube.com/feeds/api/videos/#{id}?v=2"))
    rating_string = xml.xpath("//yt:rating").to_s
    rating_string[/numLikes=\"(\d+)/]
    likes = $1.to_i
    rating_string[/numDislikes=\"(\d+)/]
    dislikes = $1.to_i

    if likes + dislikes == 0
      0
    else
      ( 100.0 * likes / ( likes + dislikes )).to_i
    end
  end
end
