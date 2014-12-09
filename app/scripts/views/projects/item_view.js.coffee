define [
  "app"
  "hbs!templates/projects/item"
], (App, tpl) ->
  Backbone.Marionette.ItemView.extend
    template: tpl
    tagName: "li"

    events:
      "click button": "showProject"

    showProject: ->
      App.commands.execute "show:project", @model
