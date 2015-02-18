define [
  "backbone"
], (Backbone) ->

  Backbone.Collection.extend
    url: "https://www.pivotaltracker.com/services/v5/my/activity"

    withStoryId: (storyId) ->
      @select (model) ->
        if resources = model.get("primary_resources")
          resources.length && resources[0].id == storyId
        else
          false
