class Video < ActiveRecord::Base
  attr_accessor :url, :playlist_id
  attr_accessible :url, :playlist_id, :youtube_id, :rating, :name
  has_many :pl_additions
  has_many :playlists, through: :pl_additions

  before_save :create_youtube_id
  before_save :query_youtube

  private
  def create_youtube_id
    if self.url[/youtu\.be\/([^\?]*)/]
      self.youtube_id = $1
    else
      self.url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      self.youtube_id = $5
    end
  end

  def query_youtube
    require 'open-uri'
    xml = Nokogiri::XML(open("http://gdata.youtube.com/feeds/api/videos/#{self.youtube_id}"))
    logger.debug "Queried YouTube: http://gdata.youtube.com/feeds/api/videos/#{id}"
    category = xml.xpath('//media:category')[0].inner_text
    self.rating = xml.xpath('//gd:rating')[0]["average"].to_f
    self.name = xml.xpath('//media:title')[0].inner_text
  end
end
