require.config
  baseUrl: "/js"

  paths:
    app: "app"
    backbone: "vendor/backbone/backbone"
    hbs: "vendor/require-handlebars-plugin/hbs"
    jquery: "vendor/jquery/dist/jquery"
    marionette: "vendor/marionette/lib/backbone.marionette"
    moment: "vendor/moment/moment"
    underscore: "vendor/underscore/underscore"

  shim:
    jquery:
      exports: "jQuery"

    underscore:
      exports: "_"

    backbone:
      deps: ["jquery", "underscore"]
      exports: "Backbone"

    marionette:
      deps: ["jquery", "underscore", "backbone"]
      exports: "Marionette"

    moment:
      exports: "moment"

