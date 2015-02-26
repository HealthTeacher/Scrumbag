define [
  "app"
], (App) ->

  FilterItemView = Backbone.Marionette.ItemView.extend
    tagName: "li"
    template: (serializedModel) ->
      "<button>#{serializedModel.name}</button>"

    triggers:
      "click": "click"

    templateHelpers:->
      count: ->
        items = App.feed.withStoryId(@model.id)
        items.length

    initialize: (opts) ->
      @active = false

    toggle: ->
      @active = !@active

    activate: ->
      @$el.addClass("active")

    deactivate: ->
      @active = false
      @$el.removeClass("active")

  Backbone.Marionette.CollectionView.extend
    id: "view-filter-view"
    tagName: "ul"
    childView: FilterItemView

    initialize: ->
      @on "childview:click", (childView, msg) ->
        @children.each (child) ->
          child.deactivate() unless child == childView

        childView.toggle()

        if childView.active
          childView.activate()
          storyId = msg.model.get("id")
          @trigger("filter-story", storyId)
        else
          childView.deactivate()
          @trigger("clear-filters")

    onRender: ->
      @$el.css opacity: 0
      @$el.animate
        opacity: 1
        duration: 450
