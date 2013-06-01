module VideosHelper
  #given a youtube url
  #regex replace to return an embed url
  #"borrowed" from http://stackoverflow.com/questions/5909121/converting-a-regular-youtube-link-into-an-embedded-video
  def embed(youtube_id, options = {})
    autoplay = "?autoplay=1" unless options[:autoplay].nil?
      raw %Q{<iframe title="YouTube video player" width="560" height="315" src="http://www.youtube.com/embed/#{ youtube_id }#{ autoplay }" frameborder="0" allowfullscreen></iframe>}
  end

  def get_thumbnail_for(youtube_id)
    "http://img.youtube.com/vi/#{ youtube_id }/default.jpg" if youtube_id
  end
end
