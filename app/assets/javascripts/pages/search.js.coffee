$ ->
  search_box = $('.js-search-input')

  query = search_box.val()

  if query
    $('body').highlight(query)