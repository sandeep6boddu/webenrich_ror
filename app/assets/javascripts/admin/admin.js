$(document).ready(function(){
	$('.wysihtml5').each(function(i, elem) {
	  $(elem).wysihtml5();
	});
	$( ".sortable" ).sortable({
		update: function(){
			jQuery.post($(this).data('update-url'), $(this).sortable('serialize'));
		}
	});

	// TO DO: Commented for testing
	
	// $('#eg-basic').editable({
 //      inlineMode: false,
 //      buttons: ['bold', 'italic', 'underline', 'strikeThrough', 'subscript', 
 //      'superscript', 'fontFamily', 'fontSize', 'color', 'formatBlock', 
 //      'blockStyle', 'inlineStyle', 'align', 'insertOrderedList', 
 //      'insertUnorderedList', 'outdent', 'indent', 'selectAll', 'createLink', 
 //      'insertImage', 'insertVideo', 'table', 'undo', 'redo', 'html', 'save', 
 //      'insertHorizontalRule', 'uploadFile', 'removeFormat', 'fullscreen']
 //    });

 	(function(window, document, $, undefined){

		$(function () {
			'use strict';

			if ( ! $.fn.fileupload ) return;

			var element = $('#new_client');
			if ( ! element.length) return;

			// Initialize the jQuery File Upload widget:
			element.fileupload({
				// Uncomment the following to send cross-domain cookies:
				//xhrFields: {withCredentials: true},
				// url: 'server/upload'
			});

			// Enable iframe cross-domain access via redirect option:
			element.fileupload(
				'option',
				'redirect',
				window.location.href.replace(
					/\/[^\/]*$/,
					'/cors/result.html?%s'
				)
			);

			// Load existing files:
			element.addClass('fileupload-processing');
			$.ajax({
				// Uncomment the following to send cross-domain cookies:
				//xhrFields: {withCredentials: true},
				url: element.fileupload('option', 'url'),
				dataType: 'json',
				context: element[0]
			}).always(function () {
				$(this).removeClass('fileupload-processing');
			}).done(function (result) {
				$(this).fileupload('option', 'done')
					.call(this, $.Event('done'), {result: result});
			});

		});

	})(window, document, window.jQuery);
});