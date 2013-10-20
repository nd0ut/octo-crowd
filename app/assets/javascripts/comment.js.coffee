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


  $('.comment .js-comment-answer').click (e) ->
    $('.comments .js-new-comment form').remove()

    authenticity_token = $("meta[name=csrf-token]").attr("content")

    comment = $(this).closest('.comment')
    comment_id = comment.data('comment-id')
    post_id = $('.post').data('post-id')

    $form = $(JST["partials/comment_form"] (path: Routes.post_comments_path(post_id), parent: comment_id, authenticity_token: authenticity_token))

    placeholder = comment.find('.js-new-comment')

    placeholder.append($form)

    initRedactor()

    e.preventDefault()
