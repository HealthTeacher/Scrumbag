define [
  "marionette"
], (Marionette) ->
  app = new Marionette.Application()

  app.addRegions
    main: "#main-wrapper"

  app.addInitializer (options) ->
    Backbone.history.start()

  window.app = app

  return app

