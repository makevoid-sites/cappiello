// -------------------------------------
//    jQueryFlickr - get flickr photos by photoset and outputs fancybox gallery
// -------------------------------------
//
// contact @makevoid for feature requests and bugfixes
// github
//
//
// User configuration:
//
// install
var api_key = "ceedea54d4a6a93de57f7f0f8b448106"
// options
var photo_size = 30
var photo_size = 14
var photo_size = 12
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

  this.randomized = function (){
    return this.all.sort(randOrd)
  }

  // non public
  function randOrd() {
    return Math.round(Math.random()) - 0.5
  }
}

var photos = new Photos()

$(function(){
  function photo_url(photo, size) {
    return "http://farm"+photo.farm+".static.flickr.com/"+photo.server+"/"+photo.id+"_"+photo.secret+"_"+size+".jpg"
  }


  //$("#photos").append("<img src='"+photo_url+"'>")
  window.FlickrGallery = function FlickrGallery() {

    this.init = function(callback) {
      // var photoset_id = $("#photos").attr("data-set_id")
      var photoset_id = $("#photos").data("setId")
      var api_url = "https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key="+api_key+"&photoset_id="+photoset_id+"&format=json&nojsoncallback=1"

      // DEBUG IE diahanz
      // url2 = "https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=ceedea54d4a6a93de57f7f0f8b448106&photoset_id=72157625778631893&format=json&nojsoncallback=1"
      // var date = new Date();
      // $.ajax({
      //   url: url2+"&_="+date.getTime(),
      //   dataType: 'text',
      //   type: "GET",
      //   cache: false,
      //   success: function(data){
      //     data = eval("(" + data + ")");
      //     $("#photos").prepend(data.photoset.id)
      //     //console.log(data)
      //   },
      //   error: function(xhr, status, error) {
      //        $("#photos").prepend("error: "+xhr.status+", "+error)
      //    }
      // })

      $.getJSON(api_url, function(data) {

        if (callback)
          callback()

        $.each(data.photoset.photo, function(idx, photo) {
          photos.add(photo)
        })

        render_images()
      })
    }

    function render_images() {
      //console.log(photos.all)
      //console.log(photos.randomized())

      $.each(photos.randomized(), function(idx, photo) {
        klass = ""
        if (idx == 0)
          klass = " first"

        // current sizes B for fullscreen (rel) and
        full_screen_size = "b"
        normal_size = "q"  // large square
        $("#photos").append("<a class='gallery_link"+klass+" fancybox' rel='group' data-href='"+photo_url(photo, full_screen_size)+"' href='"+photo_url(photo, full_screen_size)+"' ><img src='"+photo_url(photo, normal_size)+"'></a>")

        // TODO: ?

        // $("a.gallery_link").on("click", function(evt){
        //   var elem = $(evt.currentTarget)
        //   console.log("gallery_link", elem.data("href"))
        //   // window.location = elem.data("href")
        //
        // })

        if (idx+1 >= photo_size)
          return false
      })
    }
  }

  // boot

  if ($("#photos").length != 0){
    var gallery = new FlickrGallery()
    gallery.init()
  }
})
