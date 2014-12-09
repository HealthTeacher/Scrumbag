define [
  "backbone",
  "models/project"
], (Backbone, Project) ->
  Backbone.Collection.extend
    model: Project
