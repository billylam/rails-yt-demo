class AddUrlsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :url, :string
    add_column :videos, :url_raw, :string
  end
end
