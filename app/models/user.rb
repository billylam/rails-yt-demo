class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation
  has_secure_password
  has_many :playlists
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 32 }, format: { with: /^[a-z0-9]+$/i } 
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }

  before_save :create_remember_token

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
