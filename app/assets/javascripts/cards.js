$(document).ready(function(){
  $("body").on("click", ".showhours", function(){
    $(this).next(".list-unstyled").slideToggle(500);
  });

  $("body").on("click", ".shownote", function(){
    $(this).next(".notes").slideToggle(500);
  });
});
