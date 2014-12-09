define [
  "backbone",
  "models/update"
], (Backbone, File) ->
  Backbone.Collection.extend
    model: Update
