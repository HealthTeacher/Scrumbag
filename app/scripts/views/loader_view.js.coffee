define [
  "app"
  "hbs!templates/loader"
], (App, tpl) ->
  Backbone.Marionette.ItemView.extend
    template: tpl

    ui:
      loader: "#loader"

    initialize: ->
      @projectLoaded = false

    onShow: ->
      @animateQuote()

      setTimeout =>
        @animateQuote()
      , 3000

    animateQuote: ->
      index = Math.floor((Math.random()* $('#loader li').length )+1)
      @newQuote = @$("#loader li:nth-child(#{index})")
      @activeQuote = @$("li.active")
      callback = =>
        @newQuote.animate
          opacity: 1, 500, =>
            @newQuote.addClass("active")

      if @activeQuote.length > 0
        @activeQuote.animate
          opacity: 0, 250, =>
            callback()
      else
        callback()
