module VideosHelper
  #given a youtube url
  #regex replace to return an embed url
  #"borrowed" from http://stackoverflow.com/questions/5909121/converting-a-regular-youtube-link-into-an-embedded-video
  def url_embed(url)
    id = get_id(url)
      %Q{<iframe title="YouTube video player" width="560" height="315" src="http://www.youtube.com/embed/#{ id }" frameborder="0" allowfullscreen></iframe>}
  end

  def get_rating(url)
    require 'nokogiri'
    id = get_id(url)

    xml = Nokogiri::XML(open("http://gdata.youtube.com/feeds/api/videos/#{ id }?v=2"))
    rating_string = xml.xpath("//yt:rating").to_s
    rating_string[/numLikes=\"(\d+)/]
    likes = $1.to_i
    rating_string[/numDislikes=\"(\d+)/]
    dislikes = $1.to_i

    ( 100.0 * likes / ( likes + dislikes )) unless likes + dislikes == 0
  end

  private
    def get_id(url)
      #for youtu.be urls
      if url[/youtu\.be\/([^\?]*)/]
        id = $1
      else
        url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
        id = $5
      end
    end
end
