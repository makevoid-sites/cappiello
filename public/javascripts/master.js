$(function(){

  $("#js_enabled").val("true")

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

  if ($(".borse_di_studio form").length > 0)
    $(".borse_di_studio form").validate()

  klass = ""
  agent = navigator.userAgent
  if (agent.match(/Chrome/)) {
    klass = "chrome"
  } else if (agent.match(/MSIE/)) {
    klass = "ie"
  }
  $("body").addClass(klass)

  if ($(".offer section").length > 0) {

    $(".offer section").hoverIntent(function(){
      $(this).animate({height: "120px"}, 500).css({cursor: "pointer"})
    }, function(){
      $(this).animate({height: "80px"}, 700)
    }, 1)

    $(".offer section").on("click", function(){
      var self = this
      $(this).animate({height: "560px"}, 300, function(){

          $('html, body').animate({
          	scrollTop: $(self).offset().top
          }, 300)
      })
    })
  }

  function hide_flashes() {
    $('#flashes').slideUp("slow");
  }

  // banner

  if ($('#banner').length > 0) {

    // if !webkit
    $('#banner').cycle({
      fx: 'fade',
      speed:    1000,
      timeout:  5000,
      pause:    true
    });
    setTimeout(hide_flashes, 3000)

    $('#banner img').on("click", function(){
      var page_url = $(this).data("page-url")
      if (page_url)
        window.location = "/pages/"+page_url
    })
  }


  // slider generica
//
//   // if !webkit
//   $('#slider1').cycle({
//     fx: 'fade',
//     speed:    1000,
//     timeout:  5000,
//     pause:    true
//   });
//   setTimeout(hide_flashes, 3000)
// $('#slider2').cycle({
//     fx: 'fade',
//     speed:    1000,
//     timeout:  5000,
//     pause:    true
//   });
//   setTimeout(hide_flashes, 3000)
// $('#slider3').cycle({
//     fx: 'fade',
//     speed:    1000,
//     timeout:  5000,
//     pause:    true
//   });
  setTimeout(hide_flashes, 3000)

  $(".fancybox").fancybox();

})
