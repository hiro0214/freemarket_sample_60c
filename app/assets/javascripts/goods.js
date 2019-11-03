$(document).on('turbolinks:load', function() {

  function good(){
    $(".balloon").animate({opacity: 0},1000)
  }

  $(document).on("click", ".good_btn", function(){
    $(".balloon").animate({opacity: 1},1000, function(){
      setTimeout(good, 3000)
    })
  })
});