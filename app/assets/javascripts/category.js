$(document).on('turbolinks:load', function() {

  function appendOption(category){
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml =  111
  }







  $(".exhibit__detail__container__title_field").on("change", function(){
    var parentcategory = $("#chose-category").val()
    if (parentcategory != "---"){
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_name: parentcategory },
        dataType: 'json'
      })

      .done(function(children){
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })

      .fail(function(){
      })
    }
  })
});