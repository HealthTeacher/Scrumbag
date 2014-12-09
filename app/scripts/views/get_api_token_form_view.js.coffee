define [
  "app",
  "hbs!templates/get_api_token"
], (app, tpl) ->
  Backbone.Marionette.ItemView.extend
    template: tpl

    ui:
      apiToken: "#js-api-token"

    events:
      "submit": "storeToken"

    storeToken: (e) ->
      e.preventDefault()
      app.apiToken = @ui.apiToken.val()
      if app.apiToken
        @trigger("appToken:saved")

