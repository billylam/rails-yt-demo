class Video < ActiveRecord::Base
  attr_accessor :url
  attr_accessible :url, :youtube_id, :rating, :name
  has_many :pl_additions
  has_many :playlists, through: :pl_additions
end
