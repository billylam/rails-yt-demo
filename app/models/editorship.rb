class Editorship < ActiveRecord::Base
  attr_accessible :editor_id, :user_id

  belongs_to :user, class_name: "User"
  belongs_to :editor, class_name: "User"
end
