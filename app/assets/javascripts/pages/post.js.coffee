$ ->
  $('.post .js-post-delete').click (e) ->
    if confirm("Are you sure?")
      post_id = $('.post').data('post-id')

      $.ajax
        url: Routes.post_path(post_id, format: 'json')
        type: 'delete'

        statusCode:
          200: =>
            $(this).html(JST["partials/deleted"]())

    e.preventDefault()
