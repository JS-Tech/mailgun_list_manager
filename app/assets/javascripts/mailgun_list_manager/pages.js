// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on("ready page:load", function() {
  init();
});


function init() {
  $("#lists-wrapper").on("click", ".list .title", function() {
    $(this).next().toggle();
  });

  $("#lists-wrapper").on("click", ".list .update-modal .close", function() {
    $(".update-modal").hide();
  });
}
