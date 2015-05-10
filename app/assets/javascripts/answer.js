$(document).ready(function() {
   $('body').on('click', '.get_answer', function(e) {
   		e.preventDefault();
        var parentPost = $(this).attr('data-post-id');
        var input = $('#content');
        $('.form').show();
        if ( input.val() === "" ){
        	input.val( parentPost + '\n' );
        } else {
        	input.val(input.val() + parentPost + '\n' );
        }
        $('html,body').animate({'scrollTop' : $('#post_form').offset().top}, 200);
        
    });
});