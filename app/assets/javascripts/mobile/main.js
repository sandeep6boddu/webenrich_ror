var onReady = function(){

	var quotes = $(".quotes");
	var quoteIndex = -1;
	function showNextQuote() {
		quoteIndex++;
		quotes.eq(quoteIndex % quotes.length)
		.fadeIn(400)
		.delay(3000)
		.fadeOut(400, showNextQuote);
	}
	showNextQuote();

	// clients
	$('.mobile-clients').slick({
		slidesToShow: 2,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 3000,
		focusOnSelect: true,
		pauseOnHover: false,
		arrows: true
	});

	// clients
	$('.ipad-clients').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 3000,
		focusOnSelect: true,
		pauseOnHover: false,
		arrows: true
	});

	$('.modal-trigger').leanModal();
	$('.fixed-action-btn').openFAB();
	// Initialize collapse button
	$(".button-collapse").sideNav();
	// Initialize collapsible (uncomment the line below if you use the dropdown variation)
	//$('.collapsible').collapsible();


	// mobile-dropdown

	$('.dropdown-button').dropdown({
		inDuration: 300,
		outDuration: 225,
		constrain_width: false, // Does not change width of dropdown to that of the activator
		hover: true, // Activate on hover
		gutter: 0, // Spacing from edge
		belowOrigin: false, // Displays dropdown below the button
		hover: false
		}
	);

	$('.slider').slider({full_width: true});

	$('.moblie-slide-bar').slick({
		dots: true,
		infinite: true,
		speed: 500,
		autoplay: true,
		cssEase: 'linear'
	});

	//mixitup jquery//
	$('#portfolio-level-bar').mixItUp({
		pagination: {
			limit: 4,
			loop: false,
			generatePagers: true,
			// maxPagers: 1,
			pagerClass: 'btn'
			// prevButtonHTML: '<<',
			// nextButtonHTML: '>>'
		},
		controls: {
			 enable: true
		},
		callbacks: {
			onMixEnd: function(state){
				jQuery('#portfolio-level-bar').attr('data-url-prefix', state.activeFilter.substring(1));
			}
		}
	});

	jQuery('.portfolio-details-link').click(function(){
		var url = jQuery(this).attr('href');
		url = '/portfolio/'+jQuery('#portfolio-level-bar').attr('data-url-prefix')+url.substring(10);
		window.location = url;
		return false;
	});
		//mixitup jquery//
	// accordian
	$(".interested-in .quote-item").on("click", function () {
		jQuery(this).find('.project-type').toggleClass('active-tab');
		if ($(this).find('.project-type input[type=hidden]').val() == '') {
			$(this).find('.project-type input[type=hidden]').val(jQuery(this).attr('data-value'));
		} else {
			$(this).find('.project-type input[type=hidden]').val('');
		}
	});

	$(".also-interested-in .quote-item").on("click", function () {
		jQuery(this).find('.project-type').toggleClass('active-tab');
		if ($(this).find('.project-type input[type=hidden]').val() == '') {
			$(this).find('.project-type input[type=hidden]').val(jQuery(this).attr('data-value'));
		} else {
			$(this).find('.project-type input[type=hidden]').val('');
		}
	});
	$( ".quote-budget-input .quote-budget" ).click(function() {
		jQuery('.quote-budget-input .quote-budget .project-type').removeClass('active-tab');
		jQuery(this).find('.project-type').addClass('active-tab');
		jQuery('.quote-budget-input #quote_budget').val( $( this ).attr('data-value') );
	});

	$( ".start-date-input .start-date" ).click(function() {
		jQuery('.start-date-input .start-date .project-type').removeClass('active-tab');
		jQuery(this).find('.project-type').addClass('active-tab');
		jQuery('.start-date-input #quote_start_date').val( $( this ).attr('data-value') );
	});

	jQuery('.other-text').click(function(){
		return false;
	});

	$('.collapsible').collapsible({
		accordion : false // A setting that changes the collapsible behavior to expandable instead of the default accordion style
	});

	$('select').material_select();
	$('ul.tabs').tabs();

	$('.fulloverlay').click(function(){
		$(this).fadeOut();
		$('.dropdown-content').fadeOut();
	});

	$('.dropdown-button').click(function(){
		$('.fulloverlay').fadeIn();
	});

	//google map

	$('#map-canvas').gmap3({
		map: {
			options: {
			maxZoom: 18
			}
		},
		marker:{
			latLng:[17.426303, 78.536666],
			options: {
				icon: new google.maps.MarkerImage(
				"http://webenrich.com/assets/we-map-icon-58ee281789e59825312e2ebf1ff4ff05a86a2a3cee2a47fd25fb36da1c401aca.png",
				new google.maps.Size(32, 39, "px", "px")
				),
				content:  '',
			}
		}
	},
	"autofit" );
}

$(document).on('page:load', onReady);
$(document).on('ready', onReady);
Turbolinks.enableProgressBar();
