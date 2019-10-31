$(document).on('turbolinks:load', function() {

  var view_box = $('.exhibit__upload_image_field');
  $(".up-image").on('change', function(){
    var fileprop = $(this).prop('files')[0],
        find_img = $(this).next('img'),
        fileRdr = new FileReader();

    if (find_img.length) {
        find_img.nextAll().remove();
        find_img.remove();
    }

    var img = '<img class="img_view"><br><button class="img_del">削除</button>';

    $(".exhibit__upload_image_field").text("")
    view_box.append(img);

    fileRdr.onload = function() {
      view_box.find('img').attr('src', fileRdr.result);
      img_del(view_box);
    }
    fileRdr.readAsDataURL(fileprop);
  });

  function img_del(target){
    target.find("button.img_del").on('click',function(){

    if (window.confirm('サーバーから画像を削除します。\nよろしいですか？')) {
      $(this).parent().find('input[type=file]').val('');
      $(this).parent().find('.img_view, br').remove();
      $(this).remove();
      var p = `<p>クリックしてファイルをアップロード</p>`
      $(".exhibit__upload_image_field").append(p)
      }
      return false;
    });
  }
});