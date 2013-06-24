class PlAddition < ActiveRecord::Base
  default_scope order('pl_additions.id asc')
  attr_accessible :playlist_id, :video_id
  belongs_to :playlist
  belongs_to :video
end
