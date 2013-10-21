$ ->
  offset = 220
  duration = 500

  $(window).scroll ->
    if $(this).scrollTop() > offset
      $(".scroll-to-top").fadeIn duration
    else
      $(".scroll-to-top").fadeOut duration

  $(".scroll-to-top").click (event) ->
    event.preventDefault()
    $("html, body").animate
      scrollTop: 0
    , duration
    false

  $(window).scroll ->
    if $(this).scrollTop() < offset
      $(".scroll-to-bottom").fadeIn duration
    else
      $(".scroll-to-bottom").fadeOut duration

  $(".scroll-to-bottom").click (event) ->
    event.preventDefault()
    $("html, body").animate
      scrollTop: $(document).height()
    , duration
    false

