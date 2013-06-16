class AddAdderInfoToPlAdditions < ActiveRecord::Migration
  def change
    add_column :pl_additions, :adder_id, :integer
    add_column :pl_additions, :adder_username, :string
  end
end
