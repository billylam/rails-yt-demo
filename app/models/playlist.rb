class Playlist < ActiveRecord::Base
  attr_accessible :name, :private

  has_many :pl_additions
  has_many :videos, through: :pl_additions
  belongs_to :user

  validates :user_id, presence: true
  validates :name, presence: true

  def add(video)
    pl_additions.create!(video_id: video.id)
  end
end
