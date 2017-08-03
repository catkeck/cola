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
