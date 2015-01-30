require ["app", "router"], (app, router) ->
  app.appRouter = new router()

  app.start()
