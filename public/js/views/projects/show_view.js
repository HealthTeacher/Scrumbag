(function() {
  define(["app", "hbs!templates/projects/show"], function(App, tpl) {
    return Backbone.Marionette.ItemView.extend({
      template: tpl
    });
  });

}).call(this);
