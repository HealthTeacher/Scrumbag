define [
  "backbone"
], (Backbone) ->

  Backbone.Collection.extend
    url: ->
      "https://www.pivotaltracker.com/services/v5/projects/#{@projectId}/memberships"
