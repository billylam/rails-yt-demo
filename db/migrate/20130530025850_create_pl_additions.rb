class CreatePlAdditions < ActiveRecord::Migration
  def change
    create_table :pl_additions do |t|
      t.integer :playlist_id
      t.integer :video_id

      t.timestamps
    end
  end
end
