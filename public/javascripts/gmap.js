$(function(){
  function gmap() {
    var mapDiv = document.getElementById('map_canvas')
    var latLng = new google.maps.LatLng(43.7615854, 11.2725678)
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