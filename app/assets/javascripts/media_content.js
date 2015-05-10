$(document).ready(function() {
   	$('#media').on('click', '#image', function() {
   		$('#youtube_video_form').hide();
   		$("#youtube_video").val('');
   		$('#pic_form').slideToggle(200);
    });
    $('#media').on('click', '#video', function() {
   		$('#pic_form').hide();
		$('.fileinput').fileinput('clear');
   		$('#youtube_video_form').slideToggle(200);
    });
    
});