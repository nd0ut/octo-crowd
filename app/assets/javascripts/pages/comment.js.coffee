$ ->
  # кнопка удаления коммента
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


  # кнопка добавления коммента
  $('.comment .js-comment-answer').click (e) ->

    # прячем форму если она уже открыта
    existing_form = $(this).closest('.comment').find('form')
    if(existing_form.length != 0)
      existing_form.remove()
      e.preventDefault()
      return

    # прячем остальные открытые формы
    $('.comments .js-comment-body form').remove()

    # csrf
    authenticity_token = $("meta[name=csrf-token]").attr("content")

    comment = $(this).closest('.comment')
    comment_id = comment.data('comment-id')
    post_id = $('.post').data('post-id')

    # рендерим форму
    $form = $(JST["partials/comment_form"] (path: Routes.post_comments_path(post_id), parent: comment_id, authenticity_token: authenticity_token))

    placeholder = comment.find('.js-comment-body')

    placeholder.append($form)

    # иницилизируем редактор
    initRedactor()

    e.preventDefault()
