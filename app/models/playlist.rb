class Playlist < ActiveRecord::Base
  attr_accessible :name
  has_many :pl_additions
  has_many :videos, through: :pl_additions
  belongs_to :user
  validates :user_id, presence: true
end
