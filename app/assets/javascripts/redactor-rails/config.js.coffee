@initRedactor = ->
  csrf_token = $("meta[name=csrf-token]").attr("content")
  csrf_param = $("meta[name=csrf-param]").attr("content")

  params = undefined
  params = csrf_param + "=" + encodeURIComponent(csrf_token)  if csrf_param isnt `undefined` and csrf_token isnt `undefined`

  $("#new_post .js-redactor").redactor
    imageUpload:  "/redactor_rails/pictures?" + params
    imageGetJson: "/redactor_rails/pictures"
    fileUpload:   "/redactor_rails/documents?" + params
    fileGetJson:  "/redactor_rails/documents"
    path:         "/assets/redactor-rails"
    css:          "style.css"
    minHeight:    200
    removeEmptyTags: false


    buttonsAdd: ['|', 'cut']
    buttonsCustom:
      cut:
        title:    'Cut'
        callback: (buttonName, buttonDOM, buttonObject) ->
          this.insertHtml('<cut/><br>');

    blurCallback: (e) ->
      this.$source.blur()

    changeCallback: (e) ->
      this.$source.blur()


  $(".js-new-comment .js-redactor").redactor
    imageUpload:  "/redactor_rails/pictures?" + params
    imageGetJson: "/redactor_rails/pictures"
    fileUpload:   "/redactor_rails/documents?" + params
    fileGetJson:  "/redactor_rails/documents"
    path:         "/assets/redactor-rails"
    css:          "style.css"
    minHeight:    150

$ ->
  @initRedactor()