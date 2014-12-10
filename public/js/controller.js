(function() {
  define(["app", "marionette", "layout"], function(app, Marionette, MainLayout) {
    return Marionette.Controller.extend({
      getApiToken: function() {
        var layout;
        layout = new MainLayout;
        app.main.show(layout);
        if (app.apiToken) {
          return layout.fetchProjects();
        } else {
          return layout.getApiToken();
        }
      }
    });
  });

}).call(this);
