(function() {
  define(["app", "hbs!templates/projects/item"], function(app, ProjectItemView, tpl) {
    return Backbone.Marionette.ItemView.extend({
      template: tpl
    });
  });

}).call(this);
