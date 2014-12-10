define [
  "marionette"
], (Marionette) ->
  app = new Marionette.Application()

  app.addRegions
    main: "#main-wrapper"

  app.addInitializer (options) ->
    Backbone.history.start({pushState: true})

  window.app = app

  app.apiToken = localStorage["apiToken"]

  app.navigate = (route,  options) ->
    options || (options = {})
    Backbone.history.navigate(route, options)

  return app

