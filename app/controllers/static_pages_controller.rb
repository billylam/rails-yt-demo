class StaticPagesController < ApplicationController
  def home
    render 'playlists/show'
  end
end
