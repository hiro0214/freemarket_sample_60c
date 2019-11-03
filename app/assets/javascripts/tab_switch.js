$(document).on('turbolinks:load', function() {

  let tabs = $(".menu_item");
  function tabSwitch() {
    $(".active").removeClass("active");
    $(this).addClass("active");
    const index = tabs.index(this);
    $(".exhibiting_main__middle_menu__contents > ul > li").removeClass("show").eq(index).addClass("show");
  }

  tabs.click(tabSwitch);
});