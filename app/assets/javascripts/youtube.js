$(document).ready(function() {
  $('.playlistThumb').click(function(event){
    changeVideo($(this).data('position'));
    $('.videoName').text($(this).data('name'));
  });
});

