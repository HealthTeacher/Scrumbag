(function() {
  require(["app", "router"], function(app, router) {
    app.appRouter = new router();
    return app.start();
  });

}).call(this);
