class PlaylistsController < ApplicationController
  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = Playlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @playlists }
    end
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    unless Playlist.count == 0
      @playlist = Playlist.find(params[:id])
      authorize! :view, @playlist, :message => "This playlist is private."
      @videos = @playlist.videos

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @playlist }
      end
    else
      redirect_to playlists_path
    end
  end

  # GET /playlists/new
  # GET /playlists/new.json
  def new
    if signed_in?
      @playlist = current_user.playlists.build
    else
      @playlist = User.first.playlists.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
    @playlist = Playlist.find(params[:id])
  end

  # POST /playlists
  # POST /playlists.json
  def create
    if signed_in?
      @playlist = current_user.playlists.new(params[:playlist])
    else
      @playlist = User.first.playlists.new(params[:playlist])
    end

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render json: @playlist, status: :created, location: @playlist }
      else
        format.html { render action: "new" }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to playlists_url }
      format.json { head :no_content }
    end
  end
end
