window.navigator.geolocation.getCurrentPosition(function(pos){
  console.log('lat:', pos.coords.latitude, 'lon:', pos.coords.longitude);
})
