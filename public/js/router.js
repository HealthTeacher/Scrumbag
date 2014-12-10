(function() {
  define(["app", "controller"], function(app, MainController) {
    return Marionette.AppRouter.extend({
      controller: new MainController,
      appRoutes: {
        "": "getApiToken",
        "/projects": "projectsList"
      }
    });
  });

}).call(this);
