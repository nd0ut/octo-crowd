$ ->
  $category = $('.category-list a.category')

  # при наведении на категорию делаем видимой нужную иконку и показываем показываем меню
  $category.mouseenter ->
    if $(this).data('subscribed')
      $(this).find('.js-subscribed').show()
      $(this).find('.js-unsubscribed').hide()
    else
      $(this).find('.js-subscribed').hide()
      $(this).find('.js-unsubscribed').show()

    $(this).find('.js-hidden-menu').show()

  # при убирании курсора с категории скрываем меню
  $category.mouseleave ->
    $(this).find('.js-hidden-menu').hide()


  $menu = $category.find('.js-hidden-menu')

  $subscribe_button = $menu.find('.js-subscribe')

  # при наведении на иконку меняем её на противоположную
  $subscribe_button.mouseenter ->
    $(this).find('i.js-subscribed').toggle()
    $(this).find('i.js-unsubscribed').toggle()

  # при убирании курсора с иконки
  # смотрим оставить текущую иконки или заменить на противоположную
  $subscribe_button.mouseleave ->
    $category = $(this).closest('.category')

    if $category.data('subscribed')
      $category.find('.js-subscribed').show()
      $category.find('.js-unsubscribed').hide()
    else
      $category.find('.js-subscribed').hide()
      $category.find('.js-unsubscribed').show()


  # при клике на иконку смотрим
  # нужно подписаться на категорию или отписаться
  $subscribe_button.click (e) ->
    $category = $(this).closest('.category')
    category_id = $category.data('category-id')

    subscribed = $category.data('subscribed')

    if subscribed
      $.ajax
        url: Routes.category_unsubscribe_path(category_id)
        type: 'post'

        statusCode:
          200: =>
            $category.data('subscribed', false)

    else
      $.ajax
        url: Routes.category_subscribe_path(category_id)
        type: 'post'

        statusCode:
          200: =>
            $category.data('subscribed', true)

    e.preventDefault()