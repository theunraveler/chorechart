/* Sprockets stuff */
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap/alerts
//= require bootstrap/dropdown
//= require bootstrap/twipsy
//= require_self

$(document).ready(function() {
	// Open external links in a new window.
	$('a.external').attr('target','_blank');
	$('.tooltip').twipsy({ live: true });

	// Other behaviors.
	choreFormConditional();
	choreFormDifficultySlider();

});

/**
 * Conditionally hide the days of the week fields on the chore form.
 */
var choreFormConditional = function() {
	var selectField = $('select[name="chore[schedule_attributes][interval_unit]"]');
	var dayContainer = $('#day-selection');
	// Hide or show initially.
	if (selectField.val() !== 'week') {
		dayContainer.hide();
	}

	// Hide or show on change.
	selectField.live('change', function() {
		if ($(this).val() == 'week') {
			dayContainer.show();
		} else {
			dayContainer.hide();
			dayContainer.find('input').attr('checked', false);
		}
	});
};

/**
 * Add a jQuery UI slider to the difficulty field.
 */
var choreFormDifficultySlider = function() {
	var difficultyTextOptions = {
		1: 'Easy',
		2: 'Meh.',
		3: 'Kind of hard',
		4: 'Hard',
		5: 'Really hard'
	}
	var difficultyText = $('#difficulty-text');
	var difficultyField = $('input[name="chore[difficulty]"]');
	difficultyText.text(difficultyTextOptions[difficultyField.val() || 1]);

	$('#difficulty-slider').slider({
		min: 1,
		max: 5,
		value: difficultyField.val() || 1,
		slide: function(event, ui) {
			difficultyText.text(difficultyTextOptions[ui.value]);
		},
		change: function(event, ui) {
			difficultyField.val(ui.value);
		}
	});
};
