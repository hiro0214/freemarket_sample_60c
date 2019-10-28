$(document).on('turbolinks:load', function() {

  $(".jip").keyup(function(){
    var input = $(this).val()
    if (input.length == 7){
      var url = "/signup/jip"
      $.ajax({
        type: "get",
        url: url,
        data: {input: input},
        dataType: 'json'
      })

      .done(function(data){
        console.log(data)

        $(".prefecture").val(data.prefecture)
        $(".city").val(data.city)
        $(".town").val(data.town)
      })

      .fail(function(){
        console.log("mis")
        $(".prefecture").val("")
        $(".city").val("")
        $(".town").val("")
        // alert("正しい値を入力して下さい")
      })
    } else {
      $(".prefecture").val("")
      $(".city").val("")
      $(".town").val("")
    }
  })
});

