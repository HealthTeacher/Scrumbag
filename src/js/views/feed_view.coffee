define [
  "app"
  "moment"
  "helpers/change_formatter"
  "hbs!templates/feed_item"
], (App, moment, ChangeFormatter, tpl) ->

  FeedItemView = Backbone.Marionette.ItemView.extend
    template: tpl

    serializeData: ->
      data = Marionette.ItemView.prototype.serializeData.apply(@)
      data.iconClass = switch data.story_type
        when "feature" then "star"
        when "bug" then "bug"
        when "chore" then "cog"
      data

    initialize: (opts) ->
      activity = @model.get("activity")
      @model.set("formatted_changes", ChangeFormatter.format(activity, App.users))

    tagName: "article"
    className: ->
      kind = @model.get("kind")
      "feed-item item-kind-#{kind}"

  Backbone.Marionette.CollectionView.extend
    id: "view-feed-view"
    childView: FeedItemView

    onRender: ->
      @$el.css opacity: 0
      @$el.animate
        opacity: 1
        duration: 450

    showAll: ->
      @children.each (childView) ->
        childView.$el.show()

    filterByStoryId: (storyId) ->
      @showAll()
      item = App.stories.findWhere(id: storyId)
      @children.each (childView) ->
        childView.$el.hide() unless childView.model.id == item.id
