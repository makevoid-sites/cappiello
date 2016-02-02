$(function(){
  function gmap() {
    var mapDiv = document.getElementById('map_canvas')
    var latLngCenter = new google.maps.LatLng(43.7658448, 11.2574707)
    var latLng = new google.maps.LatLng(43.7615854, 11.2725678)
    var map = new google.maps.Map(mapDiv, {
      center: latLngCenter,
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      scrollwheel: false,
    })
      console.log(map)
    var marker = new google.maps.Marker({
      position: latLng,
      map: map
    })
  }

  gmap()
})
