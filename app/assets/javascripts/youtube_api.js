//A thin wrapper around YouTube API

//Load IFrame YouTube API
//Construct Player
//  The Player will automatically load and replace any found divs of the form: 
//  <div id="player"> </div>
var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
var player;

function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '345',
         width: '615',
         playerVars: {'playlist':[idList]},
         events: {
           'onReady': onPlayerReady,
         'onStateChange': onPlayerStateChange
         }
  });
}

//
// Variables
//

// Set this to reload youtube player with the latest playlist.
// This will defer reload until it is least perceptible to user.
var reload=false;

// Current index of video playing.
var currentPos;

// A javascript representation of YouTube ids currently in playlist.
//   May be ahead of videos loaded by YouTube player.
var idList = [];

//
// Event handlers
//
function onPlayerReady(event) {
}

function onPlayerStateChange(event) {
  //Unstarted occurs on page load and any video change, 
  //  and impact of reload time is minimal for user.
  if (reload && reload == true && event.data == YT.PlayerState.UNSTARTED) {
    currentPos = player.getPlaylistIndex();  
    changeVideo(currentPos);
  }
  if (event.data == YT.PlayerState.UNSTARTED) {
    showMetadata();
  }
}

//
// Methods
//

// Updates metadata information using data-name and data-description fields
function showMetadata() {
  currentPos = player.getPlaylistIndex();
  if ($('.playlistThumb').length) {
    $('.videoName').text($('.playlistThumb').eq(currentPos).data('name'));
    $('.descriptionBox').text($('.playlistThumb').eq(currentPos).data('description'));
  }
}

// Adds a video
//   NOTE: The YouTube player's playlist is not reloaded until video is changed.
function addVideo(youtube_id) {
  idList.push(youtube_id)
  reload = true;
}

// Change to video, immediately also reloading that playlist's list of videos.
function changeVideo(position) {
  reload = false;
  player.loadPlaylist(idList, position);
}


//
//jQuery
//

$(document).ready(function() {
  $("#playlist").on("click", ".playlistItem li", function(event){
    changeVideo($(this).find('.playlistThumb').data('position'));
    // This is still necessary because requesting current index from youtube is async and not guaranteed to return actual index 
    $('.videoName').text($(this).find('.playlistThumb').data('name'));
    $('.descriptionBox').text($(this).find('.playlistThumb').data('description'));

    // Ensure show hide button is shown after first video added to new playlist.
    $('#showhide').show();
  });

  $("#addVideoBtn").click(function() {
    $('#video_notices').hide().fadeIn('slow');
  });

  // Show hide description toggle
  $('.description, #showhide').click(function() {
    $('.videoAttributesBox').toggleClass('expanded');
    $('#showhide').text($('#showhide').text() == 'Show more' ? 'Show less' : 'Show more');
  });

  //onload

  // Hide showhide button if playlist is empty
  if ($.trim($('.videoName').text()) == '') {
    $('#showhide').hide();
  }
});

