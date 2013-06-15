$(document).ready(function() {
  $("#playlist").on("click", ".playlistItem li", function(event){
    // if reload is true, we need to immediately reload playlist 
    if (reload == true) {
      reloadPlaylist($(this).find('.playlistThumb').data('position'));
    }
    changeVideo($(this).find('.playlistThumb').data('position'));
    $('.videoName').text($(this).find('.playlistThumb').data('name'));
    $('.descriptionBox').text($(this).find('.playlistThumb').data('description'));
  });

  $("#addVideoBtn").click(function() {
    $('#video_notices').hide().fadeIn('slow');
  });

  $('.description').click(function() {
    $('.descriptionBox').toggleClass('expanded');
    $('#showhide').text($('#showhide').text() == 'Show more' ? 'Show less' : 'Show more');
  });
});

