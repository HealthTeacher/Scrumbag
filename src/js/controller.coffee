define [
  "app"
  "marionette"
  "layout"
], (app, Marionette, MainLayout) ->
  Marionette.Controller.extend
    initialize: ->
      @layout = new MainLayout
      app.main.show(@layout)

    index: ->
      if app.apiToken
        @layout.index()
      else
        @layout.getApiToken()

    getApiToken: ->
      if app.apiToken
        @layout.fetchProjects()
      else
        @layout.getApiToken()

    projectsList: ->
      @layout.fetchProjects()
