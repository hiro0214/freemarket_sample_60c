$(document).on('turbolinks:load', function () {

  $(window).scroll(function () {
    $(".main_contents__box__contents__items").each(function () {
      var itemPos = $(this).offset().top;
      var scroll = $(window).scrollTop();
      if (scroll > itemPos - 580) {
        $(this).addClass("fadein");
      }
    })
  })
});