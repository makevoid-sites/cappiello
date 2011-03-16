// -------------------------------------
//    JueryFlickr by makevoid  - get flickr photos by photoset and outputs fancybox gallery
// ------------------------------------- 
//
// User configuration:
//
// install
var api_key = "ceedea54d4a6a93de57f7f0f8b448106"
// options
var photo_size = 30
var photo_size = 14
var fancybox_options = {}


// html required: 
//
// #photos{ :"data-set_id" => SET_ID }
// 


function Photos() {
  this.all = []
  
  this.add = function (photo){
    this.all.push(photo)
  }
}

var photos = new Photos()

$(function(){
  function photo_url(photo, size) {
    return "http://farm"+photo.farm+".static.flickr.com/"+photo.server+"/"+photo.id+"_"+photo.secret+"_"+size+".jpg" 
  }
  
  function render_images() {
    $.each(photos.all, function(idx, photo) {
      $("#photos").append("<a rel='group' class='fancybox' href='"+photo_url(photo, "b")+"'><img src='"+photo_url(photo, "s")+"'></a>")

      $("a.fancybox").fancybox(fancybox_options)

      if (idx+1 >= photo_size)
        return false
    })
  }
  
  //$("#photos").append("<img src='"+photo_url+"'>")
  
  var photoset_id = $("#photos").attr("data-set_id")
  var api_url = "http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key="+api_key+"&photoset_id="+photoset_id+"&format=json&nojsoncallback=1"
  
  $.getJSON(api_url, function(data) {
    $.each(data.photoset.photo, function(idx, photo) {
      photos.add(photo)
    })
    
    render_images()
  })


})
