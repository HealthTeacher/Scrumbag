define [
  "app"
], (App) ->

  FilterItemView = Backbone.Marionette.ItemView.extend
    tagName: "li"
    template: (serializedModel) ->
      "<button>#{serializedModel.name} (#{serializedModel.count})</button>"

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
      @activate() if @active

    activate: ->
      @$el.addClass("active")

    deactivate: ->
      @$el.removeClass("active")

  Backbone.Marionette.CollectionView.extend
    id: "view-filter-view"
    tagName: "ul"
    childView: FilterItemView

    initialize: ->
      @on "childview:click", (childView, msg) ->
        @children.each (child) -> child.deactivate()
        childView.toggle()
        storyId = msg.model.get("id")
        if childView.active
          @trigger("filter-story", storyId)
        else
          @trigger("clear-filters")

    onRender: ->
      @$el.css opacity: 0
      @$el.animate
        opacity: 1
        duration: 450
