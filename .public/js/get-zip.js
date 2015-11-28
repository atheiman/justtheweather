window.navigator.geolocation.getCurrentPosition(function(pos){
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
      var regex = /(\d{5})",\s*.*postal_code/;
      var matches = regex.exec(xhttp.responseText);
      console.log('ZIP code:', matches[1]);
    }
  };
  var url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=' +
            pos.coords.latitude + ',' + pos.coords.longitude+'&sensor=true';
  xhttp.open("GET", url, true);
  xhttp.send();
})
