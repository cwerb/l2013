//= require active_admin/base
$(".image").on("ajax:loading", function(e) {
    e.tagret.addClass("image-processing")
})
$(".image").on("ajax:success", function(e) {
    e.tagret.removeClass("image-processing")
    e.target.hasClass("image-blocked") ? e.tagret.addClass("image-blocked") : e.tagret.removeClass("image-blocked")
})