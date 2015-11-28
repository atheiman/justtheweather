function zipToAddress(zip) {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
      return JSON.parse(xhttp.responseText).resp.results[0].formatted_address;
    }
  };
  var url = 'https://maps.googleapis.com/maps/api/geocode/json?address=' + zip;
  xhttp.open("GET", url, true);
  xhttp.send();
}
