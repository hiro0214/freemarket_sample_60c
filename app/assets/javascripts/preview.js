$(document).on('turbolinks:load', function() {

  $('.up-image').change(function(){
    if ( !this.files.length ) {
      return;
    }
    $('#image_list').text('');

    var $files = $(this).prop('files');
    var len = $files.length;
    for ( var i = 0; i < len; i++ ) {
      var file = $files[i];
      var fr = new FileReader();

      fr.onload = function(e) {
        var src = e.target.result;
        var img = '<img src="'+ src +'"><div class="btn_list"><input type="button" value="編集" class="edit_btn"><input type="button" value="削除" class="remove_btn"></div>';
        $('#image_list').append(img);
      }
      fr.readAsDataURL(file);
    }

    $('#image_list').css('display','block');
  });

  $(document).on("click", ".remove_btn", function(){
    $(this).parent().prev().remove()
    $(this).parent().remove()
    return false;
  })

});