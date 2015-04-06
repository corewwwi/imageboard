$(document).ready(function() {
   $(".pic").click(function(e) {
    var $this = $(this);
    $this.find( "img[data-pic='show']" ).fadeOut(30, function() {
      $this.find("img[data-pic='hide']" ).fadeIn(50, function(){
        var a = $("img[data-pic='show']" ).data("pic");
        $("img[data-pic='show']" ).attr("data-pic", "var");

        var b = $("img[data-pic='hide']" ).data("pic");
        $("img[data-pic='hide']" ).attr("data-pic", "show");

        var c = $("img[data-pic='var']" ).data("pic");
        $("img[data-pic='var']" ).attr("data-pic", "hide");
      });
    });
  });
});