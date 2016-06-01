$(document).ready(function(){
  $(".showhours").click(function(){
    $(this).next(".list-unstyled").toggle(500);
  });
});

$(document).ready(function(){
  $(".shownote").click(function(){
    $(this).next(".notes").toggle(500);
  });
});
