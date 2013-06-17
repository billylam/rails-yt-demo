class CreateEditorships < ActiveRecord::Migration
  def change
    create_table :editorships do |t|
      t.integer :user_id
      t.integer :editor_id

      t.timestamps
    end

    add_index :editorships, :user_id
    add_index :editorships, :editor_id
    add_index :editorships, [:user_id, :editor_id], unique: true
  end
end
