//The below functions are used to pull the latitude and longitude of the user

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(fillInPosition);
    } else {
        //x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function fillInPosition(position) {
  var latitude = document.getElementById("latitude");
  var longitude = document.getElementById("longitude");
  latitude.value = position.coords.latitude;
  longitude.value = position.coords.longitude;
  document.getElementById("search-form").submit();
}

//The below functions are used to display the graph of listed stores on the store index page

function initializeMap(locations) {
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    if (locations != null){
      markers = handler.addMarkers(locations);
      handler.bounds.extendWith(markers);
    }
    handler.fitMapToBounds();
    if (locations != null && locations.length == 1) {
      handler.getMap().setZoom(13)
    };
  });
}

$(document).ready(function() { 
  var locations = null;
  location_input = document.getElementById("locations")
  if (location_input != null){
    locations = JSON.parse(location_input.value);
  }
  setTimeout(function(){ initializeMap(locations) }, 1500);  
});
