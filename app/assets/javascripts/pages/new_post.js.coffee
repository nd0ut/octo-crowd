$ ->
  # our form
  $form = $('form#new_post')
  $form.find('input[name="post[category_ids][]"]').remove() # simpleform creates that shit

  # click on preview button
  $form.find('.js-preview-btn').click (e) ->
    # use skim partial
    html = JST["partials/post_preview"]
      post:
        title: $form.find('[name="post[title]"]').val()
        body: $form.find('[name="post[body]"]').val()
        tags: $form.find('#post_tag_list').tokenfield('getTokens')
        author: $('.js-current-user').html()
        categories: ->
          categories = []

          # get category names from select input
          $select = $form.find('select[name="post[category_ids][]"]')

          # get category ids from select input
          ids = $select.val() || []

          # merge it
          $.each ids, (i, id) ->
            category_name = $select.find('option[value=' + id + ']').html()
            categories.push
              id: id
              name: category_name

          categories

    # remove cut
    html = $('<div>' + html + '</div>')
    html.find('cut').remove()

    # replace preview div html with partial html and animate it
    $('.js-post-preview-container').html(html)
    $('.js-post-preview').slideDown()

    $('html, body').animate({
        scrollTop: ($('.js-post-preview').first().offset().top)
    },500);

    # show post date
    window.momentjs_init()

    e.stopPropagation()
    e.preventDefault()


  # hide post preview on click
  $('.js-preview-hide').click ->
    $('.js-post-preview').slideUp()

  # init tags input
  $form.find('#post_tag_list').tokenfield
    minLength: 2


  # setup validation
  $form.validate
    ignore: ""
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

    submitHandler: (validator, form, event) ->
      post_body = $form.find('textarea[name="post[body]"]').val()
      has_cut = $('<div>' + post_body + '</div>').find('cut').length > 0

      if has_cut == true
        event.target.submit()
      else
        bootbox.dialog
          title: "There is no cut in your post"
          message: JST["partials/no_cut_modal"]()
          buttons:
            i_will:
              label: "Ok, I'll use it"
              className: 'btn-success'

            save_as_is:
              label: "Save without cut"
              className: 'btn-primary'
              callback: ->
                event.target.submit()

            cancel:
              label: "Cancel"
              className: "btn-danger"