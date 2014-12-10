define [
  "app",
  "marionette",
  "layout"
], (app, Marionette, MainLayout) ->
  Marionette.Controller.extend

    getApiToken: ->
      layout = new MainLayout
      app.main.show(layout)
      if app.apiToken
        layout.fetchProjects()
      else
        layout.getApiToken()
