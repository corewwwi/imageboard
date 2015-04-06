$(document).ready(function() {
   $('.get_answer').click(function() {
        var parentPost = $(this).attr('id');
        var input = $('#content');
        $('.form').show();
        input.val(parentPost + '\n' + input.val() );
        $('html,body').animate({'scrollTop' : $('#post_form').offset().top},200);
        return false;
    });
});