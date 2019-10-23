$(document).on('turbolinks:load', function() {

  function step1(){
    $(".step1_bar").animate({width: "106px"},2000, function(){
      $("#step2_circle").css("background", "#ea352d")
      $("#step2_text").css("color", "#ea352d")
    })
  }

  function step2(){
    $(".step2_bar").animate({width: "99px"},2000, function(){
      $("#step3_circle").css("background", "#ea352d")
      $("#step3_text").css("color", "#ea352d")
    })
  }

  function step3(){
    $(".step3_bar").animate({width: "98px"},2000 ,function(){
      $("#step4_circle").css("background", "#ea352d")
      $("#step4_text").css("color", "#ea352d")
    })
  }

  function step4(){
    $(".step4_bar").animate({width: "97px"},2000 ,function(){
      $("#step5_circle").css("background", "#ea352d")
      $("#step5_text").css("color", "#ea352d")
    })
  }

  $(window).on("load", function(){
    if(document.URL.match("/step2")) {
      step1()
    }
    if(document.URL.match("/step3")) {
      $(".step1_bar").css("width","106px")
      $("#step2_circle").css("background", "#ea352d")
      $("#step2_text").css("color", "#ea352d")
    }
    if(document.URL.match("/step4")) {
      $(".step1_bar").css("width","106px")
      $("#step2_circle").css("background", "#ea352d")
      $("#step2_text").css("color", "#ea352d")
      step2()
    }
    if(document.URL.match("/step5")) {
      $(".step1_bar").css("width","106px")
      $("#step2_circle").css("background", "#ea352d")
      $("#step2_text").css("color", "#ea352d")

      $(".step2_bar").css("width","99px")
      $("#step3_circle").css("background", "#ea352d")
      $("#step3_text").css("color", "#ea352d")
      step3()
    }
  })

});