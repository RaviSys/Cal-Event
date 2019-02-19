var autocomplete_venue;
function autocompleteEvent() {
  autocomplete_venue = new google.maps.places.Autocomplete(
      (document.getElementById('autocomplete_search')),
      {types: ['geocode']});
  autocomplete_venue.addListener('place_changed', fillInAddress);
}
function fillInAddress() {
  var place = autocomplete_venue.getPlace();
  $("#lat").val(place.geometry.location.lat());
  $("#long").val(place.geometry.location.lng());
}
function geolocateEvent() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete_venue.setBounds(circle.getBounds());
    });
  }
}