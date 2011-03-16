var api_key = "ceedea54d4a6a93de57f7f0f8b448106"

var photoset_id = "72157625778629231" // interior
var photoset_id = "72157625778631893" // visual
var api_url = "http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key="+api_key+"&photoset_id="+photoset_id+"&format=json&nojsoncallback=1"
// farm
var farm = 6
var server = "5091"
var id = "5435253137"
var secret = "f1f938d567"
var size = "b"; // b: original, s: squared thumb

var photo_url = "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+"_"+size+".jpg" 
// photo_url = "http://farm6.static.flickr.com/5091/5435253137_f1f938d567_s.jpg"


var photo_size = 14
var fancybox_options = {}

$(function(){
  function photo_url(photo, size) {
    return "http://farm"+photo.farm+".static.flickr.com/"+photo.server+"/"+photo.id+"_"+photo.secret+"_"+size+".jpg" 
  }
  
  //$("#photos").append("<img src='"+photo_url+"'>")
  
  $.getJSON(api_url, function(data) {
    $.each(data.photoset.photo, function(idx, photo) {
      $("#photos").append("<a rel='group' class='fancybox' href='"+photo_url(photo, "b")+"'><img src='"+photo_url(photo, "s")+"'></a>")
      
      $("a.fancybox").fancybox(fancybox_options)
      if (idx+1 >= photo_size)
        return false 
    })
  })
  
})
