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

    templateHelpers:->
      {
        occurredAt: ->
          moment(@model.get("occurred_at")).format("dddd, MMMM Do YYYY, h:mm:ss a")
      }

    initialize: (opts) ->
      #console.log(@model.attributes)
      @model.set("formatted_changes",
        ChangeFormatter.format(@model.get("changes"), App.users))

    tagName: "article"
    className: ->
      kind = @model.get("kind")
      "feed-item item-kind-#{kind}"

  Backbone.Marionette.CollectionView.extend
    id: "view-feed-view"
    childView: FeedItemView
