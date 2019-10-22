$(document).on('turbolinks:load', function() {

  function appendlist(child){
    console.log(child)
    var html = `<li><a href="/more/${child.id}">${child.name}</li>`;
    $("#child_list").append(html)
  }

  $(".text").mouseover(
    function(){
      var href = $(this).attr("href");
      var parentID = href.replace(/[^0-9]/g, '');
      $.ajax({
        url: 'items/drop_child',
        type: 'GET',
        data: { parent: parentID },
        dataType: 'json'
      })

      .done(function(children){
        children.forEach(function(child){
          appendlist(child);
        });
      })

      .fail(function(){
        console.log("miss")
      })
    }
  )
  $(".text").mouseout(function(){
    $("#child_list").empty()
  })


});