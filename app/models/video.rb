class Video < ActiveRecord::Base
  attr_accessor :playlist_id
  attr_accessible :url_raw, :playlist_id
  has_many :pl_additions
  has_many :playlists, through: :pl_additions

  before_validation :create_youtube_id
  before_validation :query_youtube

  validates :name, presence: true
  validates :youtube_id, presence: true, uniqueness: true

  private
  def create_youtube_id
    self.youtube_id = $2 if url_raw[/^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/]
  end

  def query_youtube
    return unless self.youtube_id && self.youtube_id.length == 11 

    require 'open-uri'
    xml = Nokogiri::XML(open("http://gdata.youtube.com/feeds/api/videos/#{self.youtube_id}"))
    logger.debug "Queried YouTube: http://gdata.youtube.com/feeds/api/videos/#{id}"
    self.url = "http://www.youtube.com/watch?v=#{self.youtube_id}" 
    self.category = xml.xpath('//media:category')[0].inner_text
    self.music = (category == 'Music') ? true : false
    self.rating = xml.xpath('//gd:rating')[0]["average"].to_f
    self.name = xml.xpath('//media:title')[0].inner_text
  end
end
