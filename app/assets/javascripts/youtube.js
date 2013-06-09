$(document).ready(function() {
  $("#playlist").on("click", ".playlistThumb", function(event){
    // if reload is true, we need to immediately reload playlist 
    if (reload == true) {
      reloadPlaylist($(this).data('position'));
    }
    changeVideo($(this).data('position'));
    $('.videoName').text($(this).data('name'));
    $('.descriptionBox').text($(this).data('description'));
  });
});

