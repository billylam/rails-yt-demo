class AddHiddenUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hidden_user, :boolean, :default => false
  end
end
