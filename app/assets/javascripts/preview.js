$(document).on('turbolinks:load', function() {

  $(".up-image").change(function(){
    var file = $(this).prop('files')[0];
    if(!file.type.match('image.*')){
      return;
    }
    var fileReader = new FileReader();
    var result = $(".exhibit__upload_image_field")

    var btn = `<div class="btn_list">
                <input type="button" value="編集" class="edit_btn"></button>
                <input type="button" value="削除" class="remove_btn"></button>
              </div>`

    fileReader.onloadend = function() {
      result.html('<img class="img_preview" src="' + fileReader.result + '"/>');
      result.append(btn)
    }
    fileReader.readAsDataURL(file);
  })

  // $(document).on("click", ".remove_btn", function(){
  //   $(this).parent().remove()
  //   $(".img_preview").remove()
  //   $(".exhibit__upload_image_field").append(html)
  // })

});