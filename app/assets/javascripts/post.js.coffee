$ ->
  $('.post .js-delete').click (e) ->
    if confirm("Are you sure?")
      post_id = $(this).data('post-id')

      $.ajax
        url: Routes.post_path(post_id, format: 'json')
        type: 'delete'

        statusCode:
          200: =>
            $(this).html(JST["partials/post_deleted"]())

    e.preventDefault()
