define [
  "app"
  "moment"
  "helpers/change_formatter"
  "hbs!templates/feed/item"
  "hbs!templates/feed/story"
], (App, moment, ChangeFormatter, itemTpl, storyTpl) ->

  FeedItemView = Backbone.Marionette.ItemView.extend
    template: (serializedModel) ->
      story = serializedModel.primary_resources[0]
      story.iconClass = switch story.story_type
        when "feature"
          "star"
        when "bug"
          "bug"
        when "chore"
          "cog"

      serializedModel.story_summary = storyTpl(story)
      itemTpl(serializedModel)

    templateHelpers: ->
      occurredAt: ->
        moment(@model.get("occurred_at")).format("dddd, MMMM Do YYYY, h:mm:ss a")

    initialize: (opts) ->
      @model.set("formatted_changes",
        ChangeFormatter.format(@model.get("changes"), App.users))

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
      items = App.feed.withStoryId(storyId)
      ids = _(items).map (model) -> model.get("guid")
      @children.each (childView) ->
        unless _(ids).contains(childView.model.get("guid"))
          childView.$el.hide()
