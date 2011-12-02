$(function(){
  
  function open_in_textmate(path) {
    app_name = "cappiello"
    url = "txmt://open?url=file://~/Sites/"+app_name+"/"+path
    document.location = url
  }
  
  $("#edit_css").click(function(){
    file = "public/stylesheets/sass/main.sass"
    open_in_textmate(file)
  })
  
  $("#edit_view").click(function(){ 
    file = "app/views/"+resources+"/"+action+".html.haml"
    open_in_textmate(file)
  })
  
  $(".borse_di_studio form").validate()
  
  klass = ""
  agent = navigator.userAgent
  if (agent.match(/Chrome/)) {
    klass = "chrome"
  } else if (agent.match(/MSIE/)) {
    klass = "ie"
  }
  
  
  $("body").addClass klass
  
})