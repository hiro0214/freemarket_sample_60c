$(document).on('turbolinks:load', function() {
  $('a[href^="#"]').click(function(){
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? 'html' : href);
    var position = target.offset().top - 30;
    $('body,html').animate({scrollTop:position}, 500, 'swing');
    return false;
  });

  $(".header_alert_text > p").animate({left: "600px"}, 4000)
  $(".header_alert").fadeOut(4000)
});