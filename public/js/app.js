(function() {
  define(["marionette"], function(Marionette) {
    var app;
    app = new Marionette.Application();
    app.addRegions({
      main: "#main-wrapper"
    });
    app.addInitializer(function(options) {
      return Backbone.history.start();
    });
    window.app = app;
    app.apiToken = localStorage["apiToken"];
    return app;
  });

}).call(this);
