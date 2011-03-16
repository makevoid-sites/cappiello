var api_key = "ceedea54d4a6a93de57f7f0f8b448106"

var photoset_id = "72157625778629231"; // interior?
var url = "http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key="+api_key+"&photoset_id="+photoset_id+"&format=json"
// farm
var farm = 6
var server = "5091"
var id = "5435253137"
var secret = "f1f938d567"
var size = "b"; // b: original, s: squared thumb

var photo_url = "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+"_"+size+".jpg" 
// photo_url = "http://farm6.static.flickr.com/5091/5435253137_f1f938d567_s.jpg"

function jsonFlickrApi(rsp){

	if (rsp.stat != "ok"){

		// something broke!
		return;
	}

	for (var i=0; i<rsp.blogs.blog.length; i++){

		var blog = rsp.blogs.blog[i];

		var div = document.createElement('div');
		var txt = document.createTextNode(blog.name);

		div.appendChild(txt);
		document.body.appendChild(div);
	}
}

$(function(){
  $("#photos").append("<img src='"+photo_url+"'>");
  
  
});
