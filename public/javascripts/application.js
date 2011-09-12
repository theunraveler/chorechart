$(document).ready(function() {
	// Open external links in a new window.
	$('a.external').attr('target','_blank');

	// Other behaviors.
	choreFormConditional();

});

/**
 * Conditionally hide the days of the week fields on the chore form.
 */
var choreFormConditional = function() {
	var selectField = $('select[name="chore[schedule_attributes][interval_unit]"]');
	var dayContainer = $('p#day-selection');
	// Hide or show initially.
	if (selectField.val() !== 'week') {
		dayContainer.hide();
	}

	// Hide or show on change.
	selectField.change(function() {
		if ($(this).val() == 'week') {
			dayContainer.show();
		} else {
			dayContainer.hide();
			dayContainer.find('input').attr('checked', false);
		}
	});
};
