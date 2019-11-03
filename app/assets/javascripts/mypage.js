$(document).on('turbolinks:load', function() {

  $(".side_bar__main > ul > li , .side_bar__middle > ul > li , .side_bar__bottom > ul > li").hover(
    function(){
      $(this).children().animate({right: "6px"}, 30)
      $(this).children("i").css("color", "black")
    },
    function(){
      $(this).children().animate({right: "10px"}, 30)
      $(this).children("i").css("color", "#c9c5c5")
    }
  )
})