$ ->
  search_box = $('.js-search-input')

  query = search_box.val().replace(/[-'`~!@#$%^&*()_|+=?;:'",.<>\{\}\[\]\\\/]/gi, '')

  if query
    $('body').highlight(query)