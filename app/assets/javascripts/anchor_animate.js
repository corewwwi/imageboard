$(document).on('click', '.post_anchor', function() {
	var anchorPost = $('#' + $(this).attr("data-anchor"));
	var defaultBorderColour = anchorPost.find(".post_panel").css('border-color')
	anchorPost.find(".post_panel").css({'border-color':'black'}).animate({'border-color': defaultBorderColour}, 2000);
});
