jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() { 
    // bind 'myForm' and provide a simple callback function 
    $('#post_form').ajaxForm({
    	dataType: 'script'
    }); 
}); 