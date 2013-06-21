class SearchesController < ApplicationController
  def new
  end

  def index
    if params[:text].length < 3
      flash[:error] = "Minimum search length is 3."
      redirect_to search_path
    else
      @users = User.where('username like ?', "%#{params[:text]}%")
      @playlists = Playlist.where('name like ?', "%#{params[:text]}%")
      flash.now[:notice] = "No match results" if @users.empty? && @playlists.empty?
      render 'index'
    end
  end
end
