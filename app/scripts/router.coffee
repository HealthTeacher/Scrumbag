define ["app", "controller"], (app, MainController) ->
  Marionette.AppRouter.extend
    controller: new MainController

    appRoutes: { "": "getApiToken" }
