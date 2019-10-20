$(document).on('turbolinks:load', function() {

  $(window).scroll(function(){
    $(".main_contents__box__contents__items").each(function(){
      var imgPos = $(this).offset().top;
      var scroll = $(window).scrollTop();
      var windowHeight = $(window).height();
      if (scroll > imgPos - windowHeight + windowHeight/5){
        $(this).addClass("fadein");
      }
    })
  })
});