module VideosHelper
  #given a youtube url
  #regex replace to return an embed url
  #"borrowed" from http://stackoverflow.com/questions/5909121/converting-a-regular-youtube-link-into-an-embedded-video
  def url_embed(youtube_id)
      %Q{<iframe title="YouTube video player" width="560" height="315" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end
end
