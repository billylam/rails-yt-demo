$(document).ready(function() {
  $("#playlist").on("click", ".playlistThumb", function(event){
    // if reload is true, we need to call js loadplaylist first and set it to that position
    if (reload == true) {
      reloadPlaylist($(this).data('position'));
    }
    changeVideo($(this).data('position'));
    $('.videoName').text($(this).data('name'));
  });
});

