class PlAdditionsController < ApplicationController
  def create
    #@video = Video.find || Video.create
    #playlist.add!
    # add an...  add! function to playlist, which is just a relationship.create with (video_id: param.id)
    render 'create'
  end

  def destroy
  end
end
