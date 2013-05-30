class User < ActiveRecord::Base
  attr_accessible :email, :username
  has_many :playlists
  validates :username, presence: true
end
