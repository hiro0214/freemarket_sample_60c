$(document).on('turbolinks:load', function() {

  $(".up-image").change(function(){
    // $('img').remove();
    var file = $(this).prop('files')[0];
    if(!file.type.match('image.*')){
      return;
    }
    var fileReader = new FileReader();
    var result = $(".exhibit__upload_image_field")

    var btn = `<div>
                <button>追加</button>
                <button>削除</button>
              </div>`

    fileReader.onloadend = function() {
      result.html('<img src="' + fileReader.result + '"/>');
      $(".exhibit__upload_image_field").append(btn)
    }
    fileReader.readAsDataURL(file);
  })
});