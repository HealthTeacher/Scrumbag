(function() {
  define(["app", "marionette", "layout"], function(app, Marionette, MainLayout) {
    return Marionette.Controller.extend({
      initialize: function() {
        this.layout = new MainLayout;
        return app.main.show(this.layout);
      },
      index: function() {
        if (app.apiToken) {
          return this.layout.index();
        } else {
          return this.layout.getApiToken();
        }
      },
      getApiToken: function() {
        if (app.apiToken) {
          return this.layout.fetchProjects();
        } else {
          return this.layout.getApiToken();
        }
      },
      projectsList: function() {
        return this.layout.fetchProjects();
      }
    });
  });

}).call(this);
