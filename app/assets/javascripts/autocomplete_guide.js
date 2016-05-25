function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element);
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
}

function onPlaceChanged() {
  var place = this.getPlace();

  console.log(place);  // Uncomment this line to view the full object returned by Google API.

  var form = $('.card-autocomplete-form');

  form.find('#card_formatted_address').val(place.formatted_address);

  var hours = place.opening_hours.weekday_text.join(",")
  form.find('#card_opening_hours').val(hours);
  form.find('#card_name').val(place.name);
  form.find('#card_category').val(place.types[0]);
  form.find('#card_website').val(place.website);
  form.find('#card_price_level').val(place.price_level);
  form.find('#card_rating').val(place.rating);
  form.find('#card_international_phone_number').val(place.international_phone_number);
  form.find('#card_latitude').val(place.geometry.location.lat);
  form.find('#card_longitude').val(place.geometry.location.lng);
}

google.maps.event.addDomListener(window, 'load', function() {
  initializeAutocomplete('user_input_autocomplete_address');
});
