$ ->
  $('.comment .js-comment-delete').click (e) ->
    if confirm("Are you sure?")
      post_id = $('.post').data('post-id')
      comment_id = $(this).closest('.comment').data('comment-id')

      $.ajax
        url: Routes.post_destroy_comment_path(post_id, comment_id, format: 'json')
        type: 'delete'

        statusCode:
          200: =>
            $(this).html(JST["partials/deleted"]())

    e.preventDefault()
