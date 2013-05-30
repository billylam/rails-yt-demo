class AddIndicesToPlAdditions < ActiveRecord::Migration
  def change
    add_index :pl_additions, :playlist_id
    add_index :pl_additions, [:playlist_id, :video_id], unique: true
  end
end
