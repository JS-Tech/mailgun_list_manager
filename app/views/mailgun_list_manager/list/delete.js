console.log("love rails [add list]")
$("#lists-wrapper").html("<%= j (render 'lists') %>");

// This is the same as in javascripts/pages.js
$(".list").on("click", ".title", function() {
  $(this).next().toggle();
});
