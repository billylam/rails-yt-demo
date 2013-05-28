class Video < ActiveRecord::Base
  attr_accessor :url
  attr_accessible :url, :rating
end
