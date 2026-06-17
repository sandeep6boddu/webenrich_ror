$(window).load(function() {

	$('#search_inp').focus(function() {
		if ($(this).val()=='Sie suchen etwas Bestimmtes?') {
			$(this).val("");
		}
	}).blur(function () {
		if ($(this).val() == "") {
			$(this).val("Sie suchen etwas Bestimmtes?");
		}
	});

})

$(function() {
	var pull 		= $('#pull');
		menu 		= $('#main-nav ul');
		menuHeight	= menu.height();

	$(pull).on('click', function(e) {
		e.preventDefault();
		menu.slideToggle();
	});

	$(window).resize(function(){
		var w = $(window).width();
		if(w > 320 && menu.is(':hidden')) {
			menu.removeAttr('style');
		}
	});
});