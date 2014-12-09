define [
  "app",
  "views/projects/item_view"
], (app, ProjectItemView) ->
  Backbone.Marionette.CollectionView.extend
    childView: ProjectItemView


