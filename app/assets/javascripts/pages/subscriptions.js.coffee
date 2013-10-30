$ ->
  $subscruptions = $('.js-subscriptions')

  $categories = $subscruptions.find('.js-categories')

  $categories.find('.js-category').each (i, category) ->
    $category = $(category)

    $category.find('a.js-unsubscribe').click (e) ->
      category_id = $(this).closest('.js-category').attr('data-category-id')

      $.ajax
        url: Routes.category_unsubscribe_path(category_id)
        type: 'post'

        statusCode:
          200: =>
            $(this).html(JST["partials/unsubscribed"]())

            $(this).off('click');
            $(this).click (e) -> e.preventDefault()

      e.preventDefault()