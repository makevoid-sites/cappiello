$(function(){
  function gmap() {
    var mapDiv = document.getElementById('map_canvas')
    var latLng = new google.maps.LatLng(43.76389, 11.269234)
    var map = new google.maps.Map(mapDiv, {
      center: latLng,
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    })
      console.log(map)
    var marker = new google.maps.Marker({
      position: latLng,
      map: map
    })
  }

  gmap()
})