define [
  "marionette"
  "extensions/marionette"
], (Marionette) ->
  App = new Marionette.Application()

  App.addRegions
    main: "#main-wrapper"

  App.addInitializer (options) ->
    Backbone.history.start({pushState: true})

  window.app = App

  App.apiToken = localStorage["apiToken"]

  App.navigate = (route,  options) ->
    options || (options = {})
    Backbone.history.navigate(route, options)

  return App

