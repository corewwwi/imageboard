$(document).ready(function() {
   $("body").on("click", "#pic", function(e) {
    e.preventDefault();
    $(this).find("img").toggleClass( "small_pic" );
  }); 
});
