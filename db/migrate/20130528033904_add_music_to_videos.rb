class AddMusicToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :music, :boolean
  end
end
