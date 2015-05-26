$(document).ready(function() {

  $('body').on('click', "#show_form", function(e) {
  	e.preventDefault();
    $(".form").slideToggle(300);
  });
});



