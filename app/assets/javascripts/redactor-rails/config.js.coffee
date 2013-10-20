$(document).ready ->
  csrf_token = $("meta[name=csrf-token]").attr("content")
  csrf_param = $("meta[name=csrf-param]").attr("content")

  params = undefined
  params = csrf_param + "=" + encodeURIComponent(csrf_token)  if csrf_param isnt `undefined` and csrf_token isnt `undefined`

  $(".js-new-post .redactor").redactor
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


  $(".js-new-comment .redactor").redactor
    imageUpload:  "/redactor_rails/pictures?" + params
    imageGetJson: "/redactor_rails/pictures"
    fileUpload:   "/redactor_rails/documents?" + params
    fileGetJson:  "/redactor_rails/documents"
    path:         "/assets/redactor-rails"
    css:          "style.css"
    minHeight:    150