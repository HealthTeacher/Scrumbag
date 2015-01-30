(function() {
  require(["app", "router"], function(app, router) {
    app.appRouter = new router();
    console.log("start foo");
    return app.start();
  });

}).call(this);
