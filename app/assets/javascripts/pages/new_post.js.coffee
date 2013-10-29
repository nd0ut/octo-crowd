$ ->
  # our form
  $form = $('#new_post')

  # click on preview button
  $form.find('.js-preview-btn').click (e) ->
    $.post Routes.post_preview_path(), $form.serialize()

    # send ajax query which returns post's html
    $.ajax
      type: "POST"
      url: Routes.post_preview_path()
      data: $form.serialize()

      success: (data) ->
        $form.find('.js-post-preview-container').html(data.html)
        $form.find('.js-post-preview').slideDown()

        $('html, body').animate({
            scrollTop: ($form.find('.js-post-preview').first().offset().top)
        },500);

        window.momentjs_init()

    e.stopPropagation()
    e.preventDefault()


  # hide post preview
  $form.find('.js-preview-hide').click ->
    $form.find('.js-post-preview').slideUp()


  # init tags input
  $form.find('#post_tag_list').tokenfield
    minLength: 1
    maxLength: 10

  $form.submit ->
    console.log('as')

