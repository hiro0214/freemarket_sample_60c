$(function(){
  $(".exhibit__price__container__fee_field > input").keyup(function(){
    var input = $(this).val()
    if (300 < input && input <= 9999999) {
      var tax = Math.floor(input / 10)
      $(".exhibit_tax").text("¥" + tax)
      var profit = Math.floor(input - tax)
      $(".exhibit_profit").text("¥" + profit)
    }
    else {
      $(".exhibit_tax, .exhibit_profit").text("-")
    }
  })
});