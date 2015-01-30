define [
  "app",
  "hbs!templates/get_api_token"
], (App, tpl) ->
  Backbone.Marionette.ItemView.extend
    template: tpl

    ui:
      apiToken: "#js-api-token"

    events:
      "submit": "storeToken"

    storeToken: (e) ->
      e.preventDefault()
      App.apiToken = @ui.apiToken.val()
      if App.apiToken
        localStorage.setItem("apiToken", App.apiToken)
        @trigger("appToken:saved", App.apiToken)
