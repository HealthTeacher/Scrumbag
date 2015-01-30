(function() {
  requirejs.config({
    baseUrl: "./js",
    shim: {
  
    },
    paths: {
      hbs: "lib/require-handlebars-plugin/hbs",
      jquery: "lib/jquery/dist/jquery",
      marionette: "lib/marionette/lib/core/backbone.marionette",
      backbone: "lib/backbone/backbone",
      underscore: "lib/underscore/underscore",
      "backbone.babysitter": "lib/backbone.babysitter/lib/backbone.babysitter",
      "backbone.wreqr": "lib/backbone.wreqr/lib/backbone.wreqr",
      moment: "lib/moment/moment",
      "require-handlebars-plugin": "lib/require-handlebars-plugin/hbs",
      requirejs: "lib/requirejs/require"
    },
    packages: [
  
    ]
  });

}).call(this);
