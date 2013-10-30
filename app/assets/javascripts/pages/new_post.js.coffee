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
    minLength: 2

  $form.find('#post_tag_list').parent().find('.token-input').blur ->
    $form.find('#post_tag_list').blur()

  $form.find('#post_category_ids').parent().find('.search-field input').blur ->
    $form.find('#post_category_ids').blur()

  $form.validate
    onfocusout: (el, e) ->
      $(el).valid()
    rules:
      'post[body]':
        minWords: 3
        required: true

      'post[title]':
        minlength: 3
        maxlength: 15
        required: true

      'post[tag_list]':
        minlength: 1
        maxlength: 10
        required: true

      'post[category_ids][]':
        minlength: 1
        maxlength: 3
        required: true

    highlight: (element) ->
      $(element).closest(".form-group").addClass "has-error"

    unhighlight: (element) ->
      $(element).closest(".form-group").removeClass "has-error"

    errorElement: "span"
    errorClass: "help-block"
    errorPlacement: (error, element) ->
      element.closest('.form-group').append(error)

