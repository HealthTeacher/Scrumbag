(function() {
  define(["app", "hbs!templates/projects/item"], function(App, tpl) {
    return Backbone.Marionette.ItemView.extend({
      template: tpl,
      tagName: "article",
      events: {
        "click button": "showProject"
      },
      showProject: function() {}
    });
  });

}).call(this);
