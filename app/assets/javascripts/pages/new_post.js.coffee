$ ->
  # our form
  $form = $('#new_post')

  # click on preview button
  $form.find('.js-preview-btn').click (e) ->
    html = JST["partials/post_preview"]
      post:
        title: $form.find('[name="post[title]"]').val()
        body: $form.find('[name="post[body]"]').val()
        tags: $form.find('#post_tag_list').tokenfield('getTokens')
        author: $('.js-current-user').html()
        categories: ->
          categories = []

          $select = $form.find('select[name="post[category_ids][]"]')

          ids = $select.val() || []
          $.each ids, (i, id) ->
            category_name = $select.find('option[value=' + id + ']').html()
            categories.push
              id: id
              name: category_name

          categories

    $('.js-post-preview-container').html(html)
    $('.js-post-preview').slideDown()

    $('html, body').animate({
        scrollTop: ($('.js-post-preview').first().offset().top)
    },500);

    window.momentjs_init()

    e.stopPropagation()
    e.preventDefault()


  # hide post preview
  $('.js-preview-hide').click ->
    $('.js-post-preview').slideUp()


  # set of dirty hacks to make this validations work
  # don't remove timeouts
  $form.find('#post_tag_list').tokenfield
    minLength: 2

  $form.find('.tokenfield').on 'afterCreateToken', ->
    setTimeout ->
      $form.find('#post_tag_list').blur()
    , 0

  $form.find('#post_tag_list').parent().find('.token-input').blur ->
    $form.find('#post_tag_list').blur()

  $form.find('#post_category_ids').parent().find('.search-field input').blur ->
    setTimeout ->
      $form.find('#post_category_ids').blur()
    , 100

  $form.find('.chosen-select').chosen().change ->
    $form.find('#post_category_ids').blur()

  # setup validation
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

    invalidHandler: (event, validator) ->
      $.each event.target, (i, e) ->
        if $(e).attr('name') != undefined && $(e).attr('name').indexOf('post') != -1
          $(e).blur()
