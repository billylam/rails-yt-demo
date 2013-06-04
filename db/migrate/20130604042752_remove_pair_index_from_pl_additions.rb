class RemovePairIndexFromPlAdditions < ActiveRecord::Migration
  def change
    remove_index :pl_additions, [:playlist_id, :video_id]
  end
end
