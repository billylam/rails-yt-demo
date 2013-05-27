module VideosHelper
  #given a youtube url
  #regex replace to return an embed url
  #"borrowed" from http://stackoverflow.com/questions/5909121/converting-a-regular-youtube-link-into-an-embedded-video
  def url_embed(url)
    #for youtu.be urls
    if url[/youtu\.be\/([^\?]*)/]
      id = $1
    else
      url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      id = $5
    end
      %Q{<iframe title="YouTube video player" width="560" height="315" src="http://www.youtube.com/embed/#{ id }" frameborder="0" allowfullscreen></iframe>}
  end
end
