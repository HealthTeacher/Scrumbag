(function() {
  require.config({
    baseUrl: "js",
    paths: {
      app: "app",
      backbone: "vendor/backbone/backbone",
      underscore: "vendor/underscore/underscore",
      jquery: "vendor/jquery/dist/jquery",
      marionette: "vendor/marionette/lib/backbone.marionette",
      hbs: "vendor/require-handlebars-plugin/hbs"
    },
    shim: {
      jquery: {
        exports: "jQuery"
      },
      underscore: {
        exports: "_"
      },
      backbone: {
        deps: ["jquery", "underscore"],
        exports: "Backbone"
      },
      marionette: {
        deps: ["jquery", "underscore", "backbone"],
        exports: "Marionette"
      }
    }
  });

  require(["app", "router"], function(app, router) {
    app.appRouter = new router();
    return app.start();
  });

}).call(this);
