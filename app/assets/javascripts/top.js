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


  function image1(){
    $(".main__img1").animate({opacity: 0},800)
    $(".main__img2").animate({opacity: 1},800)
    setTimeout(image2, 6400)
  }

  function image2(){
    $(".main__img1").animate({opacity: 1},800)
    $(".main__img2").animate({opacity: 0},800)
    setTimeout(image1, 6400)
  }

  setTimeout(image1, 6000)




  function move(){
    window.location.href = "/items/new"
  }

  $(".exhibit__btn").click(function(){
    $(".exhibit__btn__circle").animate({borderWidth: "10px"}, 200, function(){
      // $(".exhibit__btn__circle").css("background", "white")
      $(".exhibit__btn__circle").animate({borderWidth: "0px"}, 200)
      setTimeout(move, 500)
    })
  })

$(".fortunetelling").click(function(){
  var val = Math.round( Math.random()*5 );
  if (val == 5){
    alert("大吉")
  } else if(val == 4) {
    alert("中吉")
  } else if(val == 3) {
    alert("小吉")
  } else if(val == 2) {
    alert("吉")
  } else {
    alert("大凶")
  }
})



});