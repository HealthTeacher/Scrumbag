define [
  "app",
  "hbs!templates/projects/item"
], (app, ProjectItemView, tpl) ->
  Backbone.Marionette.ItemView.extend
    template: tpl

