$(document).ready(function(){
  $(".showhours").click(function(){
    $(this).next(".list-unstyled").slideToggle(500);
  });
});

$(document).ready(function(){
  $(".shownote").click(function(){
    $(this).next(".notes").slideToggle(500);
  });
});
