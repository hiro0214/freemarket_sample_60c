$(document).on('turbolinks:load', function () {

  $(".jip").keyup(function () {
    var input = $(this).val()
    var num = input.replace(/[^0-9]/g, '');
    if (num.length == 7) {
      var url = "/signup/jip"
      $.ajax({
        type: "get",
        url: url,
        data: { input: num },
        dataType: 'json'
      })

        .done(function (data) {
          $(".prefecture").val(data.prefecture)
          $(".city").val(data.city)
          $(".town").val(data.town)
        })

        .fail(function () {
          $(".prefecture").val("")
          $(".city").val("")
          $(".town").val("")
          alert("正しい値を入力して下さい")
        })
    } else {
      $(".prefecture").val("")
      $(".city").val("")
      $(".town").val("")
    }
  })
});

