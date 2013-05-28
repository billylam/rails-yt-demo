class ChangeUrlToYoutubeIdInVideos < ActiveRecord::Migration
  def up
    rename_column :videos, :url, :youtube_id
  end

  def down
  end
end
