require ["app", "router"], (app, router) ->
  app.appRouter = new router()

  console.log "start foo"
  app.start()
