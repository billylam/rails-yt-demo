class AddIndexToVideosYoutubeId < ActiveRecord::Migration
  def change
    add_index :videos, :youtube_id, unique: true
  end
end
