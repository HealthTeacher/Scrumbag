(function() {
  define(["marionette"], function(Marionette) {
    var app;
    app = new Marionette.Application();
    app.addRegions({
      main: "#main-wrapper"
    });
    app.addInitializer(function(options) {
      return Backbone.history.start({
        pushState: true
      });
    });
    window.app = app;
    app.apiToken = localStorage["apiToken"];
    app.navigate = function(route, options) {
      options || (options = {});
      return Backbone.history.navigate(route, options);
    };
    return app;
  });

}).call(this);
