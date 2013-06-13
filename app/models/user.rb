class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation
  has_secure_password
  has_many :playlists
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 6, maximum: 32 } 
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
end
