$(document).ready(function() {
   $("#user_info").on('click', "#posts_info", function(e) {
    e.preventDefault();
    if ($(this).hasClass("active")) {
      $(this).removeClass('active');
      $('#user_posts').slideUp(200);
    } else {
     	$('#thrs_info').removeClass('active');
     	$('#user_thrs').hide();
     	$(this).addClass('active');
     	$('#user_posts').slideDown(200); 
    }     
  });
   $("#user_info").on('click', "#thrs_info", function(e) {
    e.preventDefault();
    if ($(this).hasClass("active")) {
      $(this).removeClass('active');
      $('#user_thrs').slideUp(200);
    } else {
     	$('#posts_info').removeClass('active');
     	$('#user_posts').hide();
     	$(this).addClass('active');
     	$('#user_thrs').slideDown(200);
      }   
  });
});