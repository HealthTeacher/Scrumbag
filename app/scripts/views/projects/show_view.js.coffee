define [
  "app"
  "hbs!templates/projects/show"
], (App, tpl) ->
  Backbone.Marionette.ItemView.extend
    template: tpl

