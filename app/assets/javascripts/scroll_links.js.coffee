$ ->
  duration = 500

  $(window).scroll ->
    top = $(document).height() / 3
    bottom = $(document).height()

    if top < $(this).scrollTop() && $(this).scrollTop() < bottom
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
    top = 150
    bottom = $(document).height() / 2

    if top < $(this).scrollTop() && $(this).scrollTop() < bottom
      $(".scroll-to-bottom").fadeIn duration
    else
      $(".scroll-to-bottom").fadeOut duration

  $(".scroll-to-bottom").click (event) ->
    event.preventDefault()
    $("html, body").animate
      scrollTop: $(document).height()
    , duration
    false

