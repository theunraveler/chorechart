/* Sprockets stuff */
//= require jquery.pjax

$(document).ready(function() {
	$('.pagination a').pjax('#main', {
		fragment: '#main'
	})
	
	$('#main')
	.bind('pjax:start', function() {
		$(this).css({ opacity: 0.5 });
	})
	.bind('pjax:end', function() {
		$(this).css({ opacity: 1 });
	});
});
