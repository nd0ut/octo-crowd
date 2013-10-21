$ ->
  $('.js-new-post .js-preview-btn').click (e) ->
    $.post Routes.post_preview_path(), $('#new_post').serialize()

    $.ajax
      type: "POST"
      url: Routes.post_preview_path()
      data: $('#new_post').serialize()

      success: (data) ->
        $('.js-post-preview-container').html(data.html)
        $('.js-post-preview').slideDown()

        $('html, body').animate({
            scrollTop: ($('.js-post-preview').first().offset().top)
        },500);

        window.momentjs_init()


    e.stopPropagation()
    e.preventDefault()


  $('.js-preview-hide').click ->
    $('.js-post-preview').slideUp()

  $('#post_tag_list').tokenfield()