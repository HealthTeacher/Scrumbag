define [
  "app",
  "hbs!templates/loading"
], (App, tpl) ->
  Backbone.Marionette.ItemView.extend
    template: tpl
    className: "view-loading"

    onRender: ->
      @$(".loading-wrapper").css opacity: 0
      @$(".loading-wrapper").animate
        opacity: 1
        duration: 450
