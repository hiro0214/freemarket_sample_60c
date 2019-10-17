$(document).on('turbolinks:load', function() {
  $('a[href^="#"]').click(function(){
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? 'html' : href);
    var position = target.offset().top - 30;
    $('body,html').animate({scrollTop:position}, 500, 'swing');
    return false;
  });
});