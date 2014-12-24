(function() {
  define(["marionette"], function(Marionette) {
    var App;
    App = new Marionette.Application();
    App.addRegions({
      main: "#main-wrapper"
    });
    App.addInitializer(function(options) {
      return Backbone.history.start({
        pushState: true
      });
    });
    window.app = App;
    App.apiToken = localStorage["apiToken"];
    App.navigate = function(route, options) {
      options || (options = {});
      return Backbone.history.navigate(route, options);
    };
    return App;
  });

}).call(this);
