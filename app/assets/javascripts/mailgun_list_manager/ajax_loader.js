/* global $ */
"use strict";

/* Ajax loader */

$(document).on("ready page:load", function() {
	var timer;
	$(document).ajaxStart(function(){
		timer && clearTimeout(timer);
		timer = setTimeout(function() {
			$("#overlay").fadeIn(500);
		}, 400);
	});
	$(document).ajaxStop(function(){
		clearTimeout(timer);
	  $("#overlay").fadeOut(400);
	});
});
