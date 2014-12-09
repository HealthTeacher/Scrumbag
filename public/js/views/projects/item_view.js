(function() {
  define(["app", "hbs!templates/projects/item"], function(App, tpl) {
    return Backbone.Marionette.ItemView.extend({
      template: tpl,
      tagName: "li",
      events: {
        "click button": "showProject"
      },
      showProject: function() {
        return App.commands.execute("show:project", this.model);
      }
    });
  });

}).call(this);
